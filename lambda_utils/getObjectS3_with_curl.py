import json
import subprocess
import boto3 # type: ignore

def lambda_handler(event, context):
    try:
        key = event['Records'][0]['s3']['object']['key']
        bucket_name = event['Records'][0]['s3']['bucket']['name']

        s3 = boto3.client('s3')

        refund = s3.get_object(
            Bucket=bucket_name,
            Key=key
        )

        refund_data = json.loads(refund['Body'].read().decode('utf-8'))

        refundID = refund_data.get('refund')

        if refundID:
            result = subprocess.run(
                [
                    "curl", "-X", "POST",
                    "-H", "Content-Type: application/x-www-form-urlencoded",
                    "-d", f"game=sim1&team=braza&order={refundID}",
                    "https://formspree.io/f/xzzdkpgz"
                ],
                capture_output=True,
                text=True
            )

            print("Status code:", result.returncode)
            print("Response:", result.stdout)

        else:
            print("Id do refund não existe")

        return {
            'statusCode': 200,
            'body': json.dumps('Processamento concluído')
        }

    except Exception as e:
        print(f"Erro ao processar o evento: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps('Erro interno ao processar o evento')
        }


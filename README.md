# Terraform AWS Auth

## Variables
| Nombre             | Descripción                                                                                                                                                                                                                                                                  |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| customer_prefix    | Prefijo del cliente que será parte del nombre del recurso                                                                                                                                                                                                                    |
| environment_suffix | Sufijo del ambiente que será parte del nombre del recurso                                                                                                                                                                                                                    |
| name               | Parte central del nombre del recurso                                                                                                                                                                                                                                         |
| common_tags        | Tags que serán parte del recurso                                                                                                                                                                                                                                             |
| invite_message     | Consta de un objeto con 3 atributos de tipo string, usados para el mensaje de invitación:email_message, email_subject y sms_message. Para mayor detalle seguir el [enlace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool).   |
| invite_message     | Consta de un objeto con 3 atributos de tipo string, usados para el mensaje de verificación:email_message, email_subject y sms_message. Para mayor detalle seguir el [enlace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool). |

## Testing

Para ejecutar las pruebas unitarias es necesario contar con Golang y algunas variables de ambiente.

Variables de ambiente Windows

```bat
set AWS_SECRET_ACCESS_KEY="<your-secret-access-key>"
set AWS_ACCESS_KEY_ID="<your-access-key-id>"
set AWS_DEFAULT_REGION="us-east-1"
set AWS_BACKEND_BUCKET="your-backend-bucket"
set AWS_BACKEND_KEY="terraform-aws-auth"
```

Variables de ambiente Linux

```sh
export AWS_SECRET_ACCESS_KEY="<your-secret-access-key>"
export AWS_ACCESS_KEY_ID="<your-access-key-id>"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_BACKEND_BUCKET="your-backend-bucket"
export AWS_BACKEND_KEY="terraform-aws-auth"
```

La ejecución de las pruebas se realiza con el siguiente comando:

```sh
go test *_test.go
```

> El comando se debe realizar en el directorio `test`.
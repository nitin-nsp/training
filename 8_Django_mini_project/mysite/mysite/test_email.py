from django.core.mail import send_mail
from django.core.mail import EmailMessage

def test():
    email_subject='Acitvate your account'
    email='freecontent09983@gmail.com'
    email = EmailMessage(
                    email_subject,
                    'Hi nitin Please the link below to activate your account \n',
                    'noreply@semycolon.com',
                    [email],
    )
    email.send()



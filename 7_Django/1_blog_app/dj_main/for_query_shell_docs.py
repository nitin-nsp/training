from blog.models import Post

from django.contrib.auth.models import User

User.objects.all()
User.objects.first()
User.objects.filter(username='nitin')
User.objects.filter(username='nitin').first()
user=User.objects.filter(username='nitin').first()
user.id 
user.pk # primary key

user=User.objects.get(id=1) # get using id


### for posts

Post.objects.all() # empty 
post_1=Post(title=' blog 1', content='First post content' ,author=user)

post_1.save()

Post.objects.all()



post_2=Post(title='blog2 ', content='second blog post', author_id=user.id)
post_2.save()


# get all post by a particular user
user.post_set
user.post_set.all()
user.post_set.create(title='Blog 3', content='Third post')


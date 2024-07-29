import json
import random
from posts.models import Post
def fun():
    with open('post_data.json') as f:
        post_json=json.load(f)

    for post in post_json:
        random_number = random.uniform(44, 45)
        post=Post(title=post['title'],content=post['content'],author_id=random_number)
        post.save()
        print('inserted: ')

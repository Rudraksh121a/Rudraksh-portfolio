from django.db import models

class Project(models.Model):
    
    # image of project
    image = models.ImageField(upload_to='images/')

    # title of project
    title = models.CharField(max_length=200)

    # description of project
    description = models.CharField(max_length=200)

    # github link of project
    github_link = models.CharField(max_length=200)

    #linkedin link
    linkedin_link = models.CharField(max_length=200,default="")

    category = models.CharField(max_length=200,default="")


    def __str__(self):
        return self.title
    

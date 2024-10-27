from django.shortcuts import render,get_object_or_404
from .models import Project 

# Create your views here.
def rudraksh(request):
    projects=Project.objects
    return render(request,'projects/index.html',{'project':projects})

def detail(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    return render(request, 'projects/detail.html', {'projects': project})
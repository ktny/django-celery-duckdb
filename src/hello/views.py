from django.http import HttpRequest, HttpResponse

from .tasks import add


# Create your views here.
def index(request: HttpRequest):
    task_id = add.delay(4, 4)
    return HttpResponse(task_id)

from django.http import HttpRequest, HttpResponse

from .tasks import add


def index(request: HttpRequest):
    # celeryを使うことで非同期となっているが性能検証のため結果を待ってからレスポンスする
    result = add.delay(4, 4)
    return HttpResponse(result.get())

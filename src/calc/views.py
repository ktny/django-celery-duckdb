from django.http import HttpRequest, HttpResponse

from .tasks import duck


def index(request: HttpRequest):
    # celeryを使うことで非同期となっているが性能検証のため結果を待ってからレスポンスする
    result = duck.delay(4, 4)
    return HttpResponse(result.get())

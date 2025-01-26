from django.http import HttpRequest, HttpResponse

from .tasks import duck


def index(request: HttpRequest):
    query_num = request.GET.get("q", 1)
    result = duck.delay(query_num)

    # celeryを使うことで非同期となっているが性能検証のため結果を待ってからレスポンスする
    return HttpResponse(result.get())

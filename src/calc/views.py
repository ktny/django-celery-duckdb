import time

from django.http import HttpRequest, JsonResponse

from .tasks import duck


def index(request: HttpRequest):
    start = time.perf_counter()

    query_num = request.GET.get("q", 1)
    delayed = duck.delay(query_num)
    result = delayed.get()  # 性能検証のため結果を待って取得する

    end = time.perf_counter()
    elapsed = end - start

    return JsonResponse({"data": result, "elapsed": elapsed})

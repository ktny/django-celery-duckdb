from logging import getLogger

logger = getLogger(__name__)


class LoggingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        # One-time configuration and initialization.

    def __call__(self, request):
        # Code to be executed for each request before
        # the view (and later middleware) are called.

        print(f"request: {request}")
        response = self.get_response(request)
        print(f"response: {response}")

        # Code to be executed for each request/response after
        # the view is called.

        return response

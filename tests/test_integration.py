from src.app import app

def test_home_route():
    test_client = app.test_client()
    response = test_client.get("/")
    assert response.status_code == 200
    assert b"Hello from github." in response.data

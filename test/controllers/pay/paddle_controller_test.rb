require "test_helper"

module Pay
  class PaddleControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test "should handle post requests" do
      post webhooks_paddle_path
      assert_response :success
    end

    test "should parse a paddle webhook" do
      user = User.create!
      params = {
        "alert_id": "1696127732",
        "alert_name": "subscription_created",
        "cancel_url": "https://checkout.paddle.com/subscription/cancel?user=4&subscription=5&hash=0b5a3b1a1591b839d9eafb59e190a3653198e7a4",
        "checkout_id": "7-516ec439d801fb0-6a9bc68bfd",
        "currency": "USD",
        "email": "kemmer.dexter@example.com",
        "event_time": "2020-06-02 06:05:21",
        "linked_subscriptions": "7, 9, 3",
        "marketing_consent": "1",
        "next_bill_date": "2020-06-23",
        "passthrough": "{\"owner_type\":\"User\",\"owner_id\":1}",
        "quantity": "65",
        "source": "Trial",
        "status": "trialing",
        "subscription_id": "1",
        "subscription_plan_id": "7",
        "unit_price": "unit_price",
        "update_url": "https://checkout.paddle.com/subscription/update?user=2&subscription=9&hash=fe515ea1601fd00f3217fdda7e0a52f2f24aedcf",
        "user_id": "8",
        "p_signature": "yIZmgOnMePd5nrnZkVRnZ8sV/l8Nij22e5G9fDB7PnCEgVp1oFqremMLpoovXOO1bUwaousSRaop2KckEppaJM55ArrXHXCIuVraCJGe5vmQmNK4y7CHfMD+Hu9rc4Aoo/eOxpRXQuYUayds4UJOifsVVKVOWrDL2DsAiYRZDsrjoJ+Hp0JsabwlrrvqvLWU27BfGrTaQjD5287cToaZPi8Gt/M+I/mv9BmNA71h6TjnbFh42uBUv4OeX1WrA3cWV69FG4CEEzGd1H2wwWARJy88nN+y6ZgMvAijVStfDHcpkvN/aXar/XBGi1z5FHomCW5OdOCOZuARtq8xmAd5ijy32f3ThRMcE+rYNWXEc8RQ/+YdvNKY1eEEL+uPZLNL7oHapv7hRZdbCXv+F/bo1gcLYp3oZLpkMi+GVwakPVIZEKa+FnXGD2v/LgDiuI/zIV1r7reX+lDL6QceNSY+5vDC1cCidjZAaPr3PUfI7wItwRyCic838HhreisF9eI+Z6ecOvBGpJ4to9M+6Jfk3UR2xFsNbVVtzAK8246iACuQKE5speLfCsh7sX3r6F1ngbnlsDV7Fkb7bP4tikJDiWcq3Rj9ERPfPxEC+8hY7d0knkeQjIZY3xX9i2eE/AnIA1pfKw3mjzYseLe4UzuRWGWV0jNAxkZPWbc231wCv6M="
      }

      assert_difference("Pay.subscription_model.count") do
        post webhooks_paddle_path, params: params
        assert_response :success
      end
    end
  end
end
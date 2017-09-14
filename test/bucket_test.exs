defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = start_supervised KV.Bucket
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "delete values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "x") == nil

    KV.Bucket.put(bucket, "x", "1")
    assert KV.Bucket.get(bucket, "x") == "1"

    KV.Bucket.delete(bucket, "x")
    assert KV.Bucket.get(bucket, "x") == nil

    KV.Bucket.put(bucket, "x", "2")
    assert KV.Bucket.get_and_delete(bucket, "x") == "2"
    assert KV.Bucket.get(bucket, "x") == nil
  end
end

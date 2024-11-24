from google.protobuf.internal import containers as _containers
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from typing import ClassVar as _ClassVar, Iterable as _Iterable, Optional as _Optional

DESCRIPTOR: _descriptor.FileDescriptor

class PhishingRequest(_message.Message):
    __slots__ = ("content",)
    CONTENT_FIELD_NUMBER: _ClassVar[int]
    content: str
    def __init__(self, content: _Optional[str] = ...) -> None: ...

class ComputationResponse(_message.Message):
    __slots__ = ("is_phishing", "content", "reason")
    IS_PHISHING_FIELD_NUMBER: _ClassVar[int]
    CONTENT_FIELD_NUMBER: _ClassVar[int]
    REASON_FIELD_NUMBER: _ClassVar[int]
    is_phishing: bool
    content: str
    reason: _containers.RepeatedScalarFieldContainer[str]
    def __init__(self, is_phishing: bool = ..., content: _Optional[str] = ..., reason: _Optional[_Iterable[str]] = ...) -> None: ...

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat-state.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatListNotifierState _$ChatListNotifierStateFromJson(
    Map<String, dynamic> json) {
  return _ChatListNotifierState.fromJson(json);
}

/// @nodoc
mixin _$ChatListNotifierState {
  Room? get room => throw _privateConstructorUsedError;
  List<Chat> get chats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatListNotifierStateCopyWith<ChatListNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListNotifierStateCopyWith<$Res> {
  factory $ChatListNotifierStateCopyWith(ChatListNotifierState value,
          $Res Function(ChatListNotifierState) then) =
      _$ChatListNotifierStateCopyWithImpl<$Res, ChatListNotifierState>;
  @useResult
  $Res call({Room? room, List<Chat> chats});

  $RoomCopyWith<$Res>? get room;
}

/// @nodoc
class _$ChatListNotifierStateCopyWithImpl<$Res,
        $Val extends ChatListNotifierState>
    implements $ChatListNotifierStateCopyWith<$Res> {
  _$ChatListNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? room = freezed,
    Object? chats = null,
  }) {
    return _then(_value.copyWith(
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as Room?,
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RoomCopyWith<$Res>? get room {
    if (_value.room == null) {
      return null;
    }

    return $RoomCopyWith<$Res>(_value.room!, (value) {
      return _then(_value.copyWith(room: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatListNotifierStateImplCopyWith<$Res>
    implements $ChatListNotifierStateCopyWith<$Res> {
  factory _$$ChatListNotifierStateImplCopyWith(
          _$ChatListNotifierStateImpl value,
          $Res Function(_$ChatListNotifierStateImpl) then) =
      __$$ChatListNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Room? room, List<Chat> chats});

  @override
  $RoomCopyWith<$Res>? get room;
}

/// @nodoc
class __$$ChatListNotifierStateImplCopyWithImpl<$Res>
    extends _$ChatListNotifierStateCopyWithImpl<$Res,
        _$ChatListNotifierStateImpl>
    implements _$$ChatListNotifierStateImplCopyWith<$Res> {
  __$$ChatListNotifierStateImplCopyWithImpl(_$ChatListNotifierStateImpl _value,
      $Res Function(_$ChatListNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? room = freezed,
    Object? chats = null,
  }) {
    return _then(_$ChatListNotifierStateImpl(
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as Room?,
      chats: null == chats
          ? _value._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatListNotifierStateImpl implements _ChatListNotifierState {
  const _$ChatListNotifierStateImpl(
      {this.room, required final List<Chat> chats})
      : _chats = chats;

  factory _$ChatListNotifierStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatListNotifierStateImplFromJson(json);

  @override
  final Room? room;
  final List<Chat> _chats;
  @override
  List<Chat> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  String toString() {
    return 'ChatListNotifierState(room: $room, chats: $chats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListNotifierStateImpl &&
            (identical(other.room, room) || other.room == room) &&
            const DeepCollectionEquality().equals(other._chats, _chats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, room, const DeepCollectionEquality().hash(_chats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListNotifierStateImplCopyWith<_$ChatListNotifierStateImpl>
      get copyWith => __$$ChatListNotifierStateImplCopyWithImpl<
          _$ChatListNotifierStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatListNotifierStateImplToJson(
      this,
    );
  }
}

abstract class _ChatListNotifierState implements ChatListNotifierState {
  const factory _ChatListNotifierState(
      {final Room? room,
      required final List<Chat> chats}) = _$ChatListNotifierStateImpl;

  factory _ChatListNotifierState.fromJson(Map<String, dynamic> json) =
      _$ChatListNotifierStateImpl.fromJson;

  @override
  Room? get room;
  @override
  List<Chat> get chats;
  @override
  @JsonKey(ignore: true)
  _$$ChatListNotifierStateImplCopyWith<_$ChatListNotifierStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

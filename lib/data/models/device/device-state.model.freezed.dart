// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device-state.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeviceNotifierState _$DeviceNotifierStateFromJson(Map<String, dynamic> json) {
  return _DeviceNotifierState.fromJson(json);
}

/// @nodoc
mixin _$DeviceNotifierState {
  Device? get currentDevice => throw _privateConstructorUsedError;
  List<Device> get devices => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceNotifierStateCopyWith<DeviceNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceNotifierStateCopyWith<$Res> {
  factory $DeviceNotifierStateCopyWith(
          DeviceNotifierState value, $Res Function(DeviceNotifierState) then) =
      _$DeviceNotifierStateCopyWithImpl<$Res, DeviceNotifierState>;
  @useResult
  $Res call({Device? currentDevice, List<Device> devices});

  $DeviceCopyWith<$Res>? get currentDevice;
}

/// @nodoc
class _$DeviceNotifierStateCopyWithImpl<$Res, $Val extends DeviceNotifierState>
    implements $DeviceNotifierStateCopyWith<$Res> {
  _$DeviceNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDevice = freezed,
    Object? devices = null,
  }) {
    return _then(_value.copyWith(
      currentDevice: freezed == currentDevice
          ? _value.currentDevice
          : currentDevice // ignore: cast_nullable_to_non_nullable
              as Device?,
      devices: null == devices
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<Device>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeviceCopyWith<$Res>? get currentDevice {
    if (_value.currentDevice == null) {
      return null;
    }

    return $DeviceCopyWith<$Res>(_value.currentDevice!, (value) {
      return _then(_value.copyWith(currentDevice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeviceNotifierStateImplCopyWith<$Res>
    implements $DeviceNotifierStateCopyWith<$Res> {
  factory _$$DeviceNotifierStateImplCopyWith(_$DeviceNotifierStateImpl value,
          $Res Function(_$DeviceNotifierStateImpl) then) =
      __$$DeviceNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Device? currentDevice, List<Device> devices});

  @override
  $DeviceCopyWith<$Res>? get currentDevice;
}

/// @nodoc
class __$$DeviceNotifierStateImplCopyWithImpl<$Res>
    extends _$DeviceNotifierStateCopyWithImpl<$Res, _$DeviceNotifierStateImpl>
    implements _$$DeviceNotifierStateImplCopyWith<$Res> {
  __$$DeviceNotifierStateImplCopyWithImpl(_$DeviceNotifierStateImpl _value,
      $Res Function(_$DeviceNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDevice = freezed,
    Object? devices = null,
  }) {
    return _then(_$DeviceNotifierStateImpl(
      currentDevice: freezed == currentDevice
          ? _value.currentDevice
          : currentDevice // ignore: cast_nullable_to_non_nullable
              as Device?,
      devices: null == devices
          ? _value._devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<Device>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceNotifierStateImpl
    with DiagnosticableTreeMixin
    implements _DeviceNotifierState {
  const _$DeviceNotifierStateImpl(
      {this.currentDevice, required final List<Device> devices})
      : _devices = devices;

  factory _$DeviceNotifierStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceNotifierStateImplFromJson(json);

  @override
  final Device? currentDevice;
  final List<Device> _devices;
  @override
  List<Device> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceNotifierState(currentDevice: $currentDevice, devices: $devices)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceNotifierState'))
      ..add(DiagnosticsProperty('currentDevice', currentDevice))
      ..add(DiagnosticsProperty('devices', devices));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceNotifierStateImpl &&
            (identical(other.currentDevice, currentDevice) ||
                other.currentDevice == currentDevice) &&
            const DeepCollectionEquality().equals(other._devices, _devices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentDevice,
      const DeepCollectionEquality().hash(_devices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceNotifierStateImplCopyWith<_$DeviceNotifierStateImpl> get copyWith =>
      __$$DeviceNotifierStateImplCopyWithImpl<_$DeviceNotifierStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceNotifierStateImplToJson(
      this,
    );
  }
}

abstract class _DeviceNotifierState implements DeviceNotifierState {
  const factory _DeviceNotifierState(
      {final Device? currentDevice,
      required final List<Device> devices}) = _$DeviceNotifierStateImpl;

  factory _DeviceNotifierState.fromJson(Map<String, dynamic> json) =
      _$DeviceNotifierStateImpl.fromJson;

  @override
  Device? get currentDevice;
  @override
  List<Device> get devices;
  @override
  @JsonKey(ignore: true)
  _$$DeviceNotifierStateImplCopyWith<_$DeviceNotifierStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

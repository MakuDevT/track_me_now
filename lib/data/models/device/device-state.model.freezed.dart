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

DeviceListNotifierState _$DeviceListNotifierStateFromJson(
    Map<String, dynamic> json) {
  return _DeviceNotifierState.fromJson(json);
}

/// @nodoc
mixin _$DeviceListNotifierState {
  Device? get currentDevice => throw _privateConstructorUsedError;
  double? get tempLat => throw _privateConstructorUsedError;
  double? get tempLng => throw _privateConstructorUsedError;
  List<Device> get devices => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceListNotifierStateCopyWith<DeviceListNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceListNotifierStateCopyWith<$Res> {
  factory $DeviceListNotifierStateCopyWith(DeviceListNotifierState value,
          $Res Function(DeviceListNotifierState) then) =
      _$DeviceListNotifierStateCopyWithImpl<$Res, DeviceListNotifierState>;
  @useResult
  $Res call(
      {Device? currentDevice,
      double? tempLat,
      double? tempLng,
      List<Device> devices});

  $DeviceCopyWith<$Res>? get currentDevice;
}

/// @nodoc
class _$DeviceListNotifierStateCopyWithImpl<$Res,
        $Val extends DeviceListNotifierState>
    implements $DeviceListNotifierStateCopyWith<$Res> {
  _$DeviceListNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDevice = freezed,
    Object? tempLat = freezed,
    Object? tempLng = freezed,
    Object? devices = null,
  }) {
    return _then(_value.copyWith(
      currentDevice: freezed == currentDevice
          ? _value.currentDevice
          : currentDevice // ignore: cast_nullable_to_non_nullable
              as Device?,
      tempLat: freezed == tempLat
          ? _value.tempLat
          : tempLat // ignore: cast_nullable_to_non_nullable
              as double?,
      tempLng: freezed == tempLng
          ? _value.tempLng
          : tempLng // ignore: cast_nullable_to_non_nullable
              as double?,
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
    implements $DeviceListNotifierStateCopyWith<$Res> {
  factory _$$DeviceNotifierStateImplCopyWith(_$DeviceNotifierStateImpl value,
          $Res Function(_$DeviceNotifierStateImpl) then) =
      __$$DeviceNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Device? currentDevice,
      double? tempLat,
      double? tempLng,
      List<Device> devices});

  @override
  $DeviceCopyWith<$Res>? get currentDevice;
}

/// @nodoc
class __$$DeviceNotifierStateImplCopyWithImpl<$Res>
    extends _$DeviceListNotifierStateCopyWithImpl<$Res,
        _$DeviceNotifierStateImpl>
    implements _$$DeviceNotifierStateImplCopyWith<$Res> {
  __$$DeviceNotifierStateImplCopyWithImpl(_$DeviceNotifierStateImpl _value,
      $Res Function(_$DeviceNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDevice = freezed,
    Object? tempLat = freezed,
    Object? tempLng = freezed,
    Object? devices = null,
  }) {
    return _then(_$DeviceNotifierStateImpl(
      currentDevice: freezed == currentDevice
          ? _value.currentDevice
          : currentDevice // ignore: cast_nullable_to_non_nullable
              as Device?,
      tempLat: freezed == tempLat
          ? _value.tempLat
          : tempLat // ignore: cast_nullable_to_non_nullable
              as double?,
      tempLng: freezed == tempLng
          ? _value.tempLng
          : tempLng // ignore: cast_nullable_to_non_nullable
              as double?,
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
      {this.currentDevice,
      this.tempLat,
      this.tempLng,
      required final List<Device> devices})
      : _devices = devices;

  factory _$DeviceNotifierStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceNotifierStateImplFromJson(json);

  @override
  final Device? currentDevice;
  @override
  final double? tempLat;
  @override
  final double? tempLng;
  final List<Device> _devices;
  @override
  List<Device> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceListNotifierState(currentDevice: $currentDevice, tempLat: $tempLat, tempLng: $tempLng, devices: $devices)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceListNotifierState'))
      ..add(DiagnosticsProperty('currentDevice', currentDevice))
      ..add(DiagnosticsProperty('tempLat', tempLat))
      ..add(DiagnosticsProperty('tempLng', tempLng))
      ..add(DiagnosticsProperty('devices', devices));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceNotifierStateImpl &&
            (identical(other.currentDevice, currentDevice) ||
                other.currentDevice == currentDevice) &&
            (identical(other.tempLat, tempLat) || other.tempLat == tempLat) &&
            (identical(other.tempLng, tempLng) || other.tempLng == tempLng) &&
            const DeepCollectionEquality().equals(other._devices, _devices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentDevice, tempLat, tempLng,
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

abstract class _DeviceNotifierState implements DeviceListNotifierState {
  const factory _DeviceNotifierState(
      {final Device? currentDevice,
      final double? tempLat,
      final double? tempLng,
      required final List<Device> devices}) = _$DeviceNotifierStateImpl;

  factory _DeviceNotifierState.fromJson(Map<String, dynamic> json) =
      _$DeviceNotifierStateImpl.fromJson;

  @override
  Device? get currentDevice;
  @override
  double? get tempLat;
  @override
  double? get tempLng;
  @override
  List<Device> get devices;
  @override
  @JsonKey(ignore: true)
  _$$DeviceNotifierStateImplCopyWith<_$DeviceNotifierStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

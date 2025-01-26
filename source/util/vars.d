module util.vars;

class Var(T) {
	protected {
		T _value;
		T _target;
		T _max, _min;
	}
	
	this(T value) {
		this._value = value;
	}

	this(T value, T min, T max) {
		this._value = value;
		this._max = max;
		this._min = min;
	}

	ref T value() {
		return _value;
	}

	ref T value(ref T value) {
		if (_value < _min) {
			_value = _min;
		} else if (_value > _max) {
			_value = _max;
		}
		return _value = value;
	}

	ref T target() {
		return _target;
	}

	ref T target(ref T value) {
		if (_target < _min) {
			_target = _min;
		} else if (_target > _max) {
			_target = _max;
		}
		return _target = value;
	}

	ref T max() {
		return _max;
	}

	ref T max(ref T value) {
		return _max = value;
	}

	ref T min() {
		return _min;
	}

	ref T min(ref T value) {
		return _min = value;
	}
}

class DeltaVar(T) : Var!T {
	protected {
		T _speed;
	}

	this(T value, T speed) {
		super(value);
		_speed = speed;
	}

	this(T value, T speed, T min, T max) {
		super(value, max, min);
		_speed = speed;
	}

	ref T speed() {
		return _speed;
	}

	ref T speed(ref T value) {
		return _speed = value;
	}

	void update(int delta) {
		if (!idle) {
			if (_value < _target) {
				_value += _speed * delta;
				if (_value > _target) {
					_value = _target;
				}
			} else if (_value > _target) {
				_value -= _speed * delta;
				if (_value < _target) {
					_value = _target;
				}
			}
		}
	}

	bool idle () {
		return _value == target;
	}
}
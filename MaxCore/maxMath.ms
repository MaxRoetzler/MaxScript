/*
*/

(
	struct maxMath
	(

--------------------
-- FLOAT | HELPER --
--------------------

		public function Round value factor:1.0 =
		(
			/*	Round the specified value to the nearest factor.

				Value			Float			The initial value.
				Factor			Float			An optional rounding factor, 1.0 by default.

				Return			Float			The rounded value.
			*/

			Floor ((value / factor) + 0.5) * factor;
		),

		public function Clamp value minimum maximum =
		(
			/*	Clamp the specified value into minimum and maximum range.

				Value			Float			The initial value.
				Minimum			Float			The minimum value.
				Maximum			Float			The maximum value.

				Return			Float			The clamped value.
			*/

			case of
			(
				default			  : value;
				(value < minimum) : minimum;
				(value > maximum) : maximum;
			)
		),

		public function Clamp01 value =
		(
			/*	Clamp the specified value into zero to one range.

				Value			Float			The initial value.

				Return			Float			The clamped value.
			*/

			case of
			(
				default		  : value;
				(value > 1.0) : 1.0;
				(value < 0.0) : 0.0;
			)
		),

		public function QuadraticEaseIn t =
		(
			t * t;
		),

		public function QuadraticEaseOut t =
		(
			-(t * (t - 2));
		),

		public function QuadraticEaseInOut t =
		(
			if (t < 0.5) then
			(
				2 * t * t;
			)
			else
			(
				(-2 * t * t) + (4 * t) - 1;
			)
		),

----------------------
-- INTEGER | HELPER --
----------------------

		public function Raise index count =
		(
			/*	Raise the specified index value. If the index exceeds 
				the maximum number of indices, it gets wrapped around.

				Index			Integer			The current index.
				Count			Integer			The number of indices.

				Return			Integer			The index raised by one, wrapped around count.
			*/

			1 + Mod index count;
		),

		public function Lower index count =
		(
			/*	Lower the specified index value. If the index falls
				below one, it gets wrapped around.

				Index			Integer			The current index.
				Count			Integer			The number of indices.

				Return			Integer			The index lowered by one, wrapped around count.
			*/

			1 + Mod (Mod (index - 2) count + count) count;
		),

---------------------
-- VECTOR | HELPER --
---------------------

		public function RoundVector vector factor:1.0 =
		(
			/*	Round the vector components to the nearest factor.

				Vector			Point3			The initial value.
				Factor			Float			An optional rounding factor, 1.0 by default.

				Return			Point3			The rounded vector.
			*/

			vector.x = Round vector.x factor:factor;
			vector.y = Round vector.y factor:factor;
			vector.z = Round vector.z factor:factor;

			vector;
		)
	)

	-- Register to core.
	Core.Math = maxMath ();
)
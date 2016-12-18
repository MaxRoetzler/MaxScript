/*
*/

(
	struct maxUtil
	(

-------------------
-- NODE | FILTER --
-------------------

		public function GeometryFilter node =
		(
			SuperClassOf node == GeometryClass;
		),

-------------------
-- SNAP | HELPER --
-------------------

		public function ClearSnaps =
		(
			for snap = 1 to snapMode.NumOSnaps do
			(
				for item = 1 to snapMode.GetOSnapNumItems snap do
				(
					snapMode.SetOSnapItemActive snap item false;
				)
			)

			snapMode.Active = false;
		),

		public SnapData = struct SnapData
		(
			private m_axis,
			private m_type,
			private m_snaps,
			private m_state,

			public function Save =
			(
				/*	Save the current snap configuration.
				*/

				m_snaps = #();
				m_type  = snapMode.Type;
				m_state = snapMode.Active;
				m_axis  = snapMode.AxisConstraint;

				for snap = 1 to snapMode.NumOSnaps do
				(
					m_snaps[snap] = #{};

					for item = 1 to snapMode.GetOSnapNumItems snap do
					(
						m_snaps[snap][item] = snapMode.GetOSnapItemActive snap item;
					)
				)
			),

			public function Reset =
			(
				/*	Reset the snap configuration to the saved state.
				*/

				snapMode.Type = m_type;
				snapMode.Active = m_state;
				snapMode.AxisConstraint = m_axis;
				
				for snap = 1 to snapMode.NumOSnaps do
				(
					for item = 1 to snapMode.GetOSnapNumItems snap do
					(
						snapMode.SetOSnapItemActive snap item m_snaps[snap][item];
					)
				)
			),

			on Create do
			(
				Save ();
			)
		);,

		public function SetSnap items mode =
		(
			local state = true;

			case mode of
			(
				#Exclusive: ClearSnaps ();
				#Subtract: state = false;
			)

			for i = 1 to items.Count by 2 do
			(
				snapMode.SetOSnapItemActive items[i] items[i+1] state;
			)

			snapMode.Active = true;
		),

---------------------
-- VECTOR | HELPER --
---------------------

		public function AlignVectorToCoordsys vector matrix =
		(
			/*	Get the signed axis of a matrix that is	closest to the 
				specified vector. Vector and matrix have to be in the 
				same coordinate system.

				Vector			Point3			The vector.
				Matrix			Matrix3			Matrix to find the axis.

				Return			Point3			The signed matrix axis.
			*/

			local index = 0;
			local minAngle = 0.0;
			local curAngle = 0.0;

			local axes = #(matrix[1], matrix[2], matrix[3], -matrix[1], -matrix[2], -matrix[3]);

			for i = 1 to 6 do
			(
				curAngle = Dot vector axes[i];

				if (curAngle > minAngle) do
				(
					minAngle = curAngle;
					index = i;
				)
			)

			axes[index];
		),

		public function GetViewVector =
		(
			(Inverse (GetViewTM ())).Row3;
		),

---------------------
-- MATRIX | HELPER --
---------------------

		public function GetViewMatrix =
		(
			Inverse (GetViewTM ());
		),

		public function AlignMatrixToView matrix:(Matrix3 1) =
		(
			local v = GetViewMatrix ();
			local x = AlignVectorToCoordsys v.Row1 matrix;
			local z = AlignVectorToCoordsys v.Row3 matrix;
			local y = Normalize (Cross z x);

			Matrix3 x y z matrix.Row4;
		),

		public function GetMatrixAxis matrix axis =
		(
			case axis of
			(
				#Right	:  matrix.Row1;
				#Left	: -matrix.Row1; 
				#Front	:  matrix.Row2;
				#Back	: -matrix.Row2;
				#Up		:  matrix.Row3;
				#Down	: -matrix.Row3;
			)
		),

		public function GetMirrorMatrix =
		(
			case toolmode.axisConstraints of
			(
				#X	: Matrix3 [-1,0,0] [0,1,0]  [0,0,1]  [0,0,0];
				#Y	: Matrix3 [1,0,0]  [0,-1,0] [0,0,1]  [0,0,0];
				#Z	: Matrix3 [1,0,0]  [0,1,0]  [0,0,-1] [0,0,0];
				#XY	: Matrix3 [-1,0,0] [0,-1,0] [0,0,1]  [0,0,0];
				#YZ	: Matrix3 [1,0,0]  [0,-1,0] [0,0,-1] [0,0,0];
				#ZX	: Matrix3 [-1,0,0] [0,1,0]  [0,0,-1] [0,0,0];
			)
		),

		public function GetFlattenMatrix =
		(
			case toolmode.axisConstraints of
			(
				#X	: Matrix3 [0,0,0] [0,1,0] [0,0,1] [0,0,0];
				#Y	: Matrix3 [1,0,0] [0,0,0] [0,0,1] [0,0,0];
				#Z	: Matrix3 [1,0,0] [0,1,0] [0,0,0] [0,0,0];
				#XY	: Matrix3 [0,0,0] [0,0,0] [0,0,1] [0,0,0];
				#YZ	: Matrix3 [1,0,0] [0,0,0] [0,0,0] [0,0,0];
				#ZX	: Matrix3 [0,0,0] [0,1,0] [0,0,0] [0,0,0];
			)
		),

---------------------
-- STRING | HELPER --
---------------------

		public function ReplaceChar string match replace =
		(
			/*	Replace the specified characters of the original string.

				@String		String			The original string.
				@Match		String			The matching character.
				@Replace	String			The replacement character.

				@Return		String			The string with replaced characters.
			*/

			for c = 1 to string.Count do
			(
				if (string[c] == match) do string[c] = replace;
			)

			string;
		),

		public function PurgeString string pattern =
		(
			/*	Purge all characters from the original string, except those 
				specified in the pattern.

				@String		String			The original string.
				@Pattern	String			The character set.

				@Return		String			The purged string.
			*/

			local char;
			local search;
			local result = "";

			for c = 1 to string.Count do
			(
				search = true;
				char = string[c];

				for i = 1 to pattern.Count while search do
				(
					if (char == pattern[i]) do
					(
						result += char;
						search = false;
					)
				)
			)

			result;
		),

		public function FormatDisplayUnit text =
		(
			case units.SystemType of
			(
				#Inches		: text += " in";
				#Feet		: text += " ft";
				#Miles		: text += " ml";
				#Millimeters: text += " mm";
				#Centimeters: text += " cm";
				#Meters		: text += " m";
				#Kilometers : text += " km";
			)
		),

--------------------
-- ARRAY | HELPER --
--------------------

		public function IsArray object minimum:0 =
		(
			/*	Check if the specified object is an array and has the minimum 
				amount of elements.

				@Object		Array		The array.
				@Minimum	Integer		Optional, the minimum number of items.

				@Return		Boolean		True, if the object is an array and has n items.
			*/

			(ClassOf object == Array and object.Count >= minimum);
		),

		public function SubtractArrays array subtrahend =
		(
			/*	Subtract all elements of the subtrahend array from the specified
				minuend array.

				@Array		Array		The array.
				@Array		Subtrahend	The array of items to remove.

				@Return		Array		The array minus the subtracted items.
			*/

			for item in subtrahend do
			(
				local index = FindItem array item;

				if (index != 0) do DeleteItem array index;
			)

			array;
		),

		public function IntersectArrays arrays =
		(
			/*	Find the intersecting elements between multiple (> 2) arrays.

				@Arrays		Array		Nested, minimum two dimensional array.

				@Return		Array		Common elements shared by all arrays.
			*/

			local isEqual;
			local common = #();

			for element in arrays[1] do
			(
				isEqual = true;

				for index = 2 to arrays.count while isEqual do
				(
					isEqual = FindItem arrays[index] element != 0;
				)

				if (isEqual) do
				(
					Append common element;
				)
			)

			common;
		)
	)

	-- Register to core
	Core.Util = maxUtil ();
)
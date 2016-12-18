/*
	Todo:
	•

	Issues:
	• 
*/

(
	struct maxLine
	(

-------------------
-- GET SELECTION --
-------------------

		public function IsSplineSelected node spline =
		(
			/*	Check if the spline index is selected on the node.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.

				Return			Boolean			True, if a spline is selected.

			*/

			FindItem (GetSplineSelection node) spline > 0;
		),

		public function HasKnotSelection node spline =
		(
			/*	Check if knots are selected on the specified spline.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.

				Return			Boolean			True, if knots are selected.

			*/

			(GetKnotSelection node spline).count > 0;
		),

		public function HasSegmentSelection node spline =
		(
			/*	Check if segments are selected on the specified spline.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.

				Return			Boolean			True, if segments are selected.

			*/

			(GetSegSelection node spline).count > 0;
		),


		public function GetSelectionAsKnot node spline =
		(
			/*	Get the current sub-selection as a knot selection.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.

				Return			Array			The selection at knot sub-object level.

			*/

			case subObjectLevel of
			(
				1 : GetKnotSelection node spline;
				2 : this.ConvertSegmentToKnot node spline;
				3 : this.ConvertSplineToKnot node spline;
			)
		),

		public function GetSelectionAsSegment node spline =
		(
			/*	Get the current sub-selection as a segment selection.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.

				Return			Array			The selection at segment sub-object level.

			*/

			case subObjectLevel of
			(
				1 : this.ConvertKnotToSegment node spline;
				2 : GetSegSelection node spline;
				3 : this.ConvertSplineToSegment node spline;
			)
		),

-------------------------------
-- MODIFY SELECTION --
-------------------------------

		public function GrowKnotSelection node spline knots: =
		(
			/*	Add adjacent knots to the knot selection of the specified spline.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Knots			Array			The knot selection, current by default.

				Return			Array			The modified knot selection.

			*/

			local grow = #{};

			if (knots == unsupplied) do
			(
				knots = GetKnotSelection node spline;
			)

			if (knots.Count > 0) do
			(
				local total = NumKnots node spline;
				grow[total] = false;

				if (IsClosed node spline) then
				(
					for knot in knots do
					(
						grow[knot] = true;
						grow[Core.Math.Next knot total] = true;
						grow[Core.Math.Prev knot total] = true;
					)
				) -- End handle closed spline.
				else
				(
					for knot in knots do
					(
						grow[knot] = true;

						if (knot - 1 > 0) do grow[knot - 1] = true;
						if (knot + 1 <= total) do grow[knot + 1] = true;
					)
				) -- End handle open spline.
			)

			grow as Array;
		),

		public function GrowSegmentSelection node spline segments: =
		(
			/*	Add adjacent segments to the segment selection of the specified spline.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Segments		Array			The segment selection, current by default.

				Return			Array			The modified segment selection.

			*/

			local grow = #{};

			if (segments == unsupplied) do
			(
				segments = GetSegSelection node spline;
			)

			if (segments.count > 0) do
			(
				local total = NumSegments node spline;
				grow[total] = false;

				if (IsClosed node spline) then
				(
					for segment in segments do
					(
						grow[segment] = true;
						grow[Core.Math.Next segment total] = true;
						grow[Core.Math.Prev segment total] = true;
					)
				) -- End handle closed spline.
				else
				(
					for segment in segments do
					(
						grow[segment] = true;

						if (segment - 1 > 0) do grow[segment - 1] = true;
						if (segment + 1 <= total) do grow[segment + 1] = true;
					)
				) -- End handle open spline.
			)

			grow as Array;
		),

		public function ShrinkKnotSelection node spline knots: =
		(
			/*	Remove adjacent knots from the knot selection of the specified spline.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Knots			Array			The knot selection, current by default.

				Return			Array			The modified knot selection.

			*/

			local shrink = #();

			if (knots == unsupplied) do
			(
				knots = GetKnotSelection node spline;
			)

			if (knots.count > 1) do
			(
				local flags = knots as BitArray;
				local total = NumKnots node spline;

				if (IsClosed node spline) then
				(
					for knot in knots do
					(
						if (flags[Core.Math.Next knot total] and flags[Core.Math.Prev knot total]) do
						(
							Append shrink knot;
						)
					)
				) -- End handle closed spline.
				else
				(
					for knot in knots do
					(
						if (knot == 1 and flags[2]) then
						(
							Append shrink knot;
						)
						else if (knot == total and flags[total - 1]) then
						(
							Append shrink knot;
						)
						else if (flags[Core.Math.Next knot total] and flags[Core.Math.Prev knot total]) do
						(
							Append shrink knot;
						)
					)
				) -- End handle open spline.
			)

			shrink;
		),

		public function ShrinkSegmentSelection node spline segments: =
		(
			/*	Remove adjacent segments from the segment selection of the specified spline.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Segments		Array			The segment selection, current by default.

				Return			Array			The modified segment selection.

			*/

			local shrink = #();

			if (segments == unsupplied) do
			(
				segments = GetSegSelection node spline;
			)

			if (segments.count > 1) do
			(
				local flags = segments as BitArray;
				local total = NumSegments node spline;

				if (IsClosed node spline) then
				(
					for segment in segments do
					(
						if (flags[Core.Math.Next segment total] and flags[Core.Math.Prev segment total]) do
						(
							Append shrink segment;
						)
					)
				) -- End handle closed spline.
				else
				(
					for segment in segments do
					(
						if (segment == 1 and flags[2]) then
						(
							Append shrink segment;
						)
						else if (segment == total and flags[total - 1]) then
						(
							Append shrink segment;
						)
						else if (flags[Core.Math.Next segment total] and flags[Core.Math.Prev segment total]) do
						(
							Append shrink segment;
						)
					)
				) -- End handle open spline.
			)

			shrink;
		),
		
		public function ConvertKnotToSegment node spline knots: =
		(
			/*	Convert the knot selection of specified spline, to a segment selection.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Knots			Array			The knot selection, current by default.

				Return			Array			The converted segment selection.

			*/

			if (knots == unsupplied) do
			(
				knots = GetKnotSelection node spline;
			)

			local segments = #{};
			local count = knots.count;

			if (count > 0) do
			(
				local total = NumSegments node spline;
				segments[total] = false;

				if (IsClosed node spline) then
				(
					for knot in knots do
					(
						segments[knot] = true;
						segments[Core.Math.Prev knot total] = true;
					)
				) -- End handle closed spline.
				else
				(
					for knot in knots do
					(
						if (knot <= total) do
						(
							segments[knot] = true;
						)

						if (knot > 1) do
						(
							segments[knot - 1] = true;
						)
					)
				) -- End handle open spline.
			)

			segments as Array;
		),

		public function ConvertSegmentToKnot node spline segments: =
		(
			/*	Convert the segment selection of specified spline, to a knot selection.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Segments		Array			The segment selection, current by default.

				Return			Array			The converted knot selection.

			*/

			if (segments == unsupplied) do
			(
				segments = GetSegSelection node spline;
			)

			local knots = #{};

			if (segments.count > 0) do
			(
				local total = NumKnots node spline;
				knots[total] = false;

				if (IsClosed node spline) then
				(
					for segment in segments do
					(
						knots[segment] = true;
						knots[Core.Math.Next segment total] = true;
					)
				) -- End handle closed spline.
				else
				(
					for segment in segments do
					(
						knots[segment] = true;
						knots[segment+1] = true;
					)
				) -- End handle open spline.
			)

			knots as Array;
		),

		public function ConvertSplineToKnot node spline =
		(
			/*	Convert the spline selection to a knot selection.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.

				Return			Array			The converted knot selection.

			*/

			local knots = #();

			if (IsSplineSelected node spline) do
			(
				knots = #{1..(NumKnots node spline)} as Array;
			)

			knots;
		),

		public function ConvertSplineToSegment node spline =
		(
			/*	Convert the spline selection to a segment selection.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.

				Return			Array			The converted segment selection.

			*/

			local segments = #();
		
			if (IsSplineSelected node spline) do
			(
				segments = #{1..(NumSegments node spline)} as Array;
			)

			segments;
		),

		public function CalculateKnotCenter node spline knots: =
		(
			/*	Calculate the center of the spline's knot selection.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Knots			Array			The knot selection, current by default.

				Return			Point3			The knot selection center, or [0,0,0].

			*/

			if (knots == unsupplied) do
			(
				knots = GetSelectionAsKnot node spline;
			)

			local center = Point3 0 0 0;

			for knot in knots do
			(
				center += GetKnotPoint node spline knot;
			)

			center / knots.count;
		),

		public function Transfer node spline matrix coords knots: =
		(
			/*	Multiply the current sub-object selection by the matrix in
				the specified coordinate system. Convert the current sub-
				object selection by default.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Matrix			Matrix3			The transform matrix.
				Coords			Matrix3			The coordinate system.
				Knots			Array			The knot selection, current by default.

			*/

			if (knots == unsupplied) do
			(
				knots = GetSelectionAsKnot node spline;
			)

			local center = CalculateKnotCenter node spline knots:knots;

			coords.row4 = center;

			in coordsys coords
			(
				for knot in knots do
				(
					local knotPoint = GetKnotPoint node spline knot;
					local vectorIn = GetInVec node spline knot;
					local vectorOut = GetOutVec node spline knot;

					SetKnotPoint node spline knot (knotPoint * matrix);
					SetInVec node spline knot (vectorIn * matrix);
					SetOutVec node spline knot (vectorOut * matrix);
				)
			)
		),

		public function GetSelectionMatrix node =
		(
			local center = Point3 0 0 0;
			local matrix = node.Transform;
			local knots = #();

			local centers = for spline = 1 to (NumSplines node) collect
			(
				knots = GetSelectionAsKnot node spline;
				center += CalculateKnotCenter node spline knots:knots;
			)

			matrix.Row4 = center / centers.Count;
			matrix;
		),

-------------------
-- LINE | MACROS --
-------------------

		public function DuplicateSegment node spline segments: =
		(
			/*	Add adjacent knots to the knot selection of the specified spline.

				Node			Edt_Spline		The editable spline node.
				Spline			Integer			The spline index.
				Segments		Array			The segment selection, current by default.

				Return			Array			The duplicated segments in a new spline.

			*/
		),

		public function Explode node =
		(
			/*	Explode the shape into all spline elements.

				Node			Edt_Spline		The editable spline node.

			*/

			for spline = 1 to (NumSplines node) do
			(
				local newShape = SplineShape pos:node.pos name:(node.name + spline as String);

				AddNewSpline newShape;

				for knot = 1 to (NumKnots node spline) do
				(
					AddKnot newShape 1 (GetKnotType node spline knot) #Curve (GetKnotPoint node spline knot) (GetInVec node spline knot) (GetOutVec node spline knot);
				)

				if (IsClosed node spline) do
				(
					Close newShape 1;
				)

				UpdateShape newShape;
			)

			Delete node;
		)
	)

	-- Register to core
	Core.Line = maxLine ();
)
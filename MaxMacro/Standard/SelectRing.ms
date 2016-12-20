(
	local SelectRing = function SelectRing =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.ButtonOp #SelectEdgeRing;
			)

			#EditablePoly: 
			(
				$.SelectEdgeRing ();
			)

			#UnwrapUVW: 
			(
				$.UnwrapUvw.UvRing 0;
			)
		)
	)

	Macro.SelectRing = SelectRing;
)
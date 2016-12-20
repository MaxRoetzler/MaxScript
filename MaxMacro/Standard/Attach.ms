(
	local Attach = function Attach =
	(
		case (Core.Node.GetObjectType subLevel:-1) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.EnterPickMode #Attach;	
			)

			#EditablePoly: 
			(
				$.EnterPickMode #Attach;
			)

			#EditableLine: 
			(
				SplineOps.StartAttach $;
			)

			#UnwrapUVW: 
			(
				$.UnwrapUvw.StitchVertsNoParams ();
			)
		)
	)

	Macro.Attach = Attach;
)
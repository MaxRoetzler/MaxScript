(
	local Create = function Create =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.ToggleCommandMode #CreateFace;
			)

			#EditablePoly: 
			(
				$.ToggleCommandMode #CreateFace;
			)

			#EditableLine: 
			(
				SplineOps.StartCreateLine $;
			)
		)
	)

	Macro.Create = Create;
)
macroScript MaxConvertToElement category:"Max Core" buttonText:"Convert To Element" toolTip:"Convert To Element"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			with Redraw off
			(
				local level = $.GetEPolySelLevel ();

				$.ConvertSelection #CurrentLevel #Face;
				$.SelectElement ();
				$.ConvertSelection #CurrentLevel level;
			)
		)

		#EditablePoly: 
		(
			with Redraw off
			(
				local level = $.GetEPolySelLevel ();

				$.ConvertSelection #CurrentLevel #Face;
				$.SelectElement ();
				$.ConvertSelection #CurrentLevel level;
			)
		)

		#UnwrapUVW: 
		(
			$.UnwrapUvw.SelectElement ();
		)
	)
)
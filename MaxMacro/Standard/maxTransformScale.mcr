macroScript MaxTransformScale category:"Max Core" buttonText:"Transform Scale" toolTip:"Transform Scale"
(
	case (Core.Node.GetObjectType ()) of
	(
		Default 	: max Scale;
		#UnwrapUVW	: $.Unwrap_UVW.Scale ();
	)
)
macroScript MaxTransformRotate category:"Max Core" buttonText:"Transform Rotate" toolTip:"Transform Rotate"
(
	case (Core.Node.GetObjectType ()) of
	(
		Default 	: max Rotate;
		#UnwrapUVW	: $.Unwrap_UVW.Rotate ();
	)
)
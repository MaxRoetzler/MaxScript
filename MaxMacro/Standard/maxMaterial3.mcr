macroScript MaxMaterial3 category:"Max Core" buttonText:"Material ID-3" toolTip:"Material ID-3"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 2;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 3;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[3] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[3]; 
						false : node.Material = MeditMaterials[3];
					)
				)
			)
		)
	)
)
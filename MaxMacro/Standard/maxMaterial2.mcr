macroScript MaxMaterial2 category:"Max Core" buttonText:"Material ID-2" toolTip:"Material ID-2"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 1;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 2;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[2] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[2]; 
						false : node.Material = MeditMaterials[2];
					)
				)
			)
		)
	)
)
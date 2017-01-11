macroScript MaxMaterial9 category:"Max Core" buttonText:"Material ID-9" toolTip:"Material ID-9"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 8;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 9;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[9] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[9]; 
						false : node.Material = MeditMaterials[9];
					)
				)
			)
		)
	)
)
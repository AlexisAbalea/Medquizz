import 'package:sqflite/sqflite.dart';

/// Migration 2 : Ajout de la catégorie "Préparation aux urgences" en L3
/// avec des questions sur la prise en charge des urgences hospitalières
/// Inclut : 110 questions de base + 15 questions de tri complexes
class Migration2 {
  static Future<void> migrate(Database db) async {
    // Ajouter la nouvelle catégorie avec couleur rouge pétant
    final categoryId = await db.insert('categories', {
      'name': 'Préparation aux urgences',
      'year_level': 'L3',
      'icon': 'emergency',
      'color': '#FF0000', // Rouge pétant pour mise en avant
      'description': 'Prise en charge des urgences hospitalières',
    });

    // Ajouter des questions sur les urgences
    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quelle est la priorité absolue dans la prise en charge initiale d\'un patient aux urgences ?',
      difficulty: 'Facile',
      explanation:
          'L\'évaluation des fonctions vitales (ABCDE : Airway, Breathing, Circulation, Disability, Exposure) est toujours la priorité absolue pour identifier et traiter immédiatement les situations mettant en jeu le pronostic vital.',
      answers: [
        {'text': 'Évaluer les fonctions vitales', 'isCorrect': true},
        {'text': 'Prendre la tension artérielle', 'isCorrect': false},
        {'text': 'Remplir le dossier médical', 'isCorrect': false},
        {'text': 'Faire une radiographie', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Dans le tri des patients aux urgences, quelle couleur correspond à une urgence absolue ?',
      difficulty: 'Facile',
      explanation:
          'Le code couleur rouge indique une urgence absolue nécessitant une prise en charge immédiate (patient en danger vital). Le jaune correspond à une urgence relative, le vert à une urgence mineure, et le bleu à un patient décédé.',
      answers: [
        {'text': 'Rouge', 'isCorrect': true},
        {'text': 'Jaune', 'isCorrect': false},
        {'text': 'Vert', 'isCorrect': false},
        {'text': 'Orange', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quel est le premier geste à effectuer face à un arrêt cardiaque aux urgences ?',
      difficulty: 'Moyen',
      explanation:
          'Le massage cardiaque externe doit être débuté immédiatement en cas d\'arrêt cardiaque. La règle est de commencer la réanimation cardio-pulmonaire (RCP) avec 30 compressions thoraciques suivies de 2 insufflations. Le délai avant la première compression est crucial pour le pronostic.',
      answers: [
        {'text': 'Débuter le massage cardiaque', 'isCorrect': true},
        {'text': 'Administrer de l\'adrénaline', 'isCorrect': false},
        {'text': 'Faire un électrocardiogramme', 'isCorrect': false},
        {'text': 'Intuber le patient', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quelle est la dose initiale d\'adrénaline recommandée lors d\'un arrêt cardiaque chez l\'adulte ?',
      difficulty: 'Moyen',
      explanation:
          'La dose initiale d\'adrénaline est de 1 mg en intraveineux ou intra-osseux, à renouveler toutes les 3 à 5 minutes pendant la réanimation cardio-pulmonaire selon les recommandations internationales.',
      answers: [
        {'text': '1 mg', 'isCorrect': true},
        {'text': '0.5 mg', 'isCorrect': false},
        {'text': '5 mg', 'isCorrect': false},
        {'text': '10 mg', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Devant un patient inconscient, quelle manœuvre permet de libérer les voies aériennes ?',
      difficulty: 'Facile',
      explanation:
          'La bascule de la tête en arrière avec élévation du menton permet de libérer les voies aériennes supérieures en écartant la langue de la paroi postérieure du pharynx. Attention : cette manœuvre est contre-indiquée en cas de suspicion de traumatisme cervical.',
      answers: [
        {
          'text': 'Bascule de la tête en arrière avec élévation du menton',
          'isCorrect': true
        },
        {'text': 'Position latérale de sécurité', 'isCorrect': false},
        {'text': 'Compression abdominale', 'isCorrect': false},
        {'text': 'Ventilation au masque', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quelle est la définition d\'un choc hémorragique ?',
      difficulty: 'Moyen',
      explanation:
          'Le choc hémorragique est un état de choc hypovolémique causé par une perte sanguine importante (généralement > 20-30% de la volémie), entraînant une hypoperfusion tissulaire. Il se manifeste par tachycardie, hypotension, pâleur, sueurs froides et troubles de conscience.',
      answers: [
        {
          'text': 'État d\'hypoperfusion tissulaire par perte sanguine massive',
          'isCorrect': true
        },
        {'text': 'Arrêt cardiaque par hémorragie cérébrale', 'isCorrect': false},
        {'text': 'Hypertension artérielle par stress', 'isCorrect': false},
        {'text': 'Diminution du rythme cardiaque', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Dans la prise en charge d\'un traumatisme crânien grave, quelle est la cible de pression artérielle moyenne (PAM) ?',
      difficulty: 'Difficile',
      explanation:
          'Pour assurer une perfusion cérébrale adéquate après un traumatisme crânien grave, la PAM doit être maintenue ≥ 80 mmHg selon les recommandations. Cela permet de garantir une pression de perfusion cérébrale suffisante (PPC = PAM - PIC).',
      answers: [
        {'text': '≥ 80 mmHg', 'isCorrect': true},
        {'text': '≥ 60 mmHg', 'isCorrect': false},
        {'text': '≥ 100 mmHg', 'isCorrect': false},
        {'text': '≥ 120 mmHg', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quel critère clinique oriente vers une urgence abdominale chirurgicale ?',
      difficulty: 'Moyen',
      explanation:
          'La défense abdominale (contraction réflexe et involontaire de la paroi abdominale à la palpation) est un signe de péritonite et constitue un critère majeur d\'urgence chirurgicale. Elle témoigne d\'une irritation péritonéale nécessitant souvent une intervention en urgence.',
      answers: [
        {'text': 'Défense abdominale', 'isCorrect': true},
        {'text': 'Nausées isolées', 'isCorrect': false},
        {'text': 'Diarrhée simple', 'isCorrect': false},
        {'text': 'Ballonnement abdominal', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quelle est la définition du score de Glasgow ?',
      difficulty: 'Facile',
      explanation:
          'Le score de Glasgow (GCS) est une échelle d\'évaluation de la conscience qui cotée de 3 à 15 points. Elle évalue 3 critères : l\'ouverture des yeux (1-4), la réponse verbale (1-5) et la réponse motrice (1-6). Un score ≤ 8 définit un coma.',
      answers: [
        {'text': 'Échelle d\'évaluation de la conscience', 'isCorrect': true},
        {'text': 'Score de gravité des brûlures', 'isCorrect': false},
        {'text': 'Échelle de la douleur', 'isCorrect': false},
        {'text': 'Classification des plaies', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'En cas de suspicion d\'AVC, quel examen d\'imagerie doit être réalisé en priorité ?',
      difficulty: 'Moyen',
      explanation:
          'Le scanner cérébral (TDM) sans injection est l\'examen de première intention en urgence devant un AVC suspect. Il permet de différencier rapidement un AVC ischémique (85% des cas) d\'un AVC hémorragique, ce qui conditionne totalement la prise en charge thérapeutique.',
      answers: [
        {'text': 'Scanner cérébral sans injection', 'isCorrect': true},
        {'text': 'IRM cérébrale', 'isCorrect': false},
        {'text': 'Radiographie du crâne', 'isCorrect': false},
        {'text': 'Échographie trans-crânienne', 'isCorrect': false},
      ],
    );

    // CAS CLINIQUES CONCRETS

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 65 ans arrive aux urgences avec une douleur thoracique rétrosternale intense apparue il y a 30 minutes, irradiant dans le bras gauche. Quelle est votre priorité ?',
      difficulty: 'Moyen',
      explanation:
          'Devant un tableau évocateur de syndrome coronarien aigu (douleur thoracique typique), il faut immédiatement réaliser un ECG (dans les 10 minutes) pour rechercher un infarctus du myocarde. Le diagnostic et la prise en charge rapide conditionnent le pronostic vital.',
      answers: [
        {'text': 'Réaliser un ECG en urgence', 'isCorrect': true},
        {'text': 'Faire une radiographie thoracique', 'isCorrect': false},
        {'text': 'Prescrire un bilan biologique complet', 'isCorrect': false},
        {'text': 'Administrer un antalgique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive inconscient après un accident de moto. Il présente une plaie du cuir chevelu qui saigne abondamment. Que faites-vous en premier ?',
      difficulty: 'Moyen',
      explanation:
          'Selon l\'ABCDE, A (Airway) prime toujours. Il faut sécuriser les voies aériennes tout en protégeant le rachis cervical (suspicion de traumatisme). La compression de la plaie sera faite dans un second temps.',
      answers: [
        {
          'text': 'Sécuriser les voies aériennes avec protection cervicale',
          'isCorrect': true
        },
        {'text': 'Comprimer la plaie du cuir chevelu', 'isCorrect': false},
        {'text': 'Poser une voie veineuse', 'isCorrect': false},
        {'text': 'Faire un scanner cérébral', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Une femme de 28 ans arrive avec une dyspnée aiguë, une tachycardie à 130/min et une douleur thoracique latérale. Elle rentre d\'un long voyage en avion. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'La triade dyspnée + douleur thoracique + voyage prolongé évoque une embolie pulmonaire. Les facteurs de risque incluent l\'immobilisation prolongée (voyage en avion). C\'est une urgence vitale nécessitant un diagnostic rapide (D-dimères, angio-scanner).',
      answers: [
        {'text': 'Embolie pulmonaire', 'isCorrect': true},
        {'text': 'Crise d\'asthme', 'isCorrect': false},
        {'text': 'Pneumonie', 'isCorrect': false},
        {'text': 'Crise d\'angoisse', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 3 ans arrive avec une fièvre à 40°C, des vomissements et une raideur de nuque. Quel diagnostic suspectez-vous ?',
      difficulty: 'Facile',
      explanation:
          'La triade fièvre + vomissements + raideur de nuque (syndrome méningé) évoque une méningite, urgence vitale chez l\'enfant. Une ponction lombaire sera réalisée après élimination d\'une hypertension intracrânienne.',
      answers: [
        {'text': 'Méningite', 'isCorrect': true},
        {'text': 'Gastro-entérite', 'isCorrect': false},
        {'text': 'Otite', 'isCorrect': false},
        {'text': 'Grippe', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient diabétique arrive confus, en sueurs, avec des tremblements. Sa glycémie capillaire est à 0,4 g/L. Quelle est votre prise en charge immédiate ?',
      difficulty: 'Facile',
      explanation:
          'L\'hypoglycémie sévère (< 0,5 g/L) avec signes neurologiques nécessite un resucrage immédiat. Si le patient est conscient et peut déglutir, on privilégie le resucrage oral (3 sucres). Si troubles de conscience, injection de glucagon IM ou glucose IV.',
      answers: [
        {'text': 'Resucrage immédiat (oral ou IV)', 'isCorrect': true},
        {'text': 'Injection d\'insuline', 'isCorrect': false},
        {'text': 'Scanner cérébral', 'isCorrect': false},
        {'text': 'Perfusion de sérum physiologique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 75 ans arrive avec une douleur abdominale intense, brutale, à type de déchirure, irradiant dans le dos. TA : 180/100. Quel diagnostic évoquez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Douleur abdominale brutale, déchirante, irradiant dans le dos chez un sujet âgé hypertendu évoque une dissection aortique. C\'est une urgence absolue nécessitant un angio-scanner en urgence et une prise en charge chirurgicale.',
      answers: [
        {'text': 'Dissection aortique', 'isCorrect': true},
        {'text': 'Colique néphrétique', 'isCorrect': false},
        {'text': 'Appendicite', 'isCorrect': false},
        {'text': 'Pancréatite', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive après avoir inhalé de la fumée lors d\'un incendie. Il a des suies dans les narines et une voix rauque. Quelle complication redoutez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Les signes d\'inhalation de fumée (suies, voix rauque, brûlures faciales) font craindre une atteinte des voies aériennes avec risque d\'œdème laryngé et d\'obstruction. Une intubation préventive peut être nécessaire avant l\'apparition de l\'œdème.',
      answers: [
        {'text': 'Œdème laryngé avec obstruction des voies aériennes', 'isCorrect': true},
        {'text': 'Pneumonie', 'isCorrect': false},
        {'text': 'Hémorragie digestive', 'isCorrect': false},
        {'text': 'Insuffisance rénale', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Une femme enceinte de 8 mois arrive avec des céphalées violentes, une vision floue et une TA à 170/110. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'HTA sévère + céphalées + troubles visuels chez une femme enceinte au 3e trimestre évoque une pré-éclampsie sévère, pouvant évoluer vers une éclampsie (convulsions). C\'est une urgence obstétricale nécessitant hospitalisation et traitement antihypertenseur.',
      answers: [
        {'text': 'Pré-éclampsie sévère', 'isCorrect': true},
        {'text': 'Migraine gravidique', 'isCorrect': false},
        {'text': 'Hémorragie méningée', 'isCorrect': false},
        {'text': 'Hypertension essentielle', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 45 ans arrive agité, désorienté, avec des hallucinations. Il sent l\'alcool et présente des tremblements des mains. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Confusion + hallucinations + tremblements + contexte d\'alcoolisme évoque un delirium tremens (syndrome de sevrage alcoolique sévère). C\'est une urgence nécessitant benzodiazépines, vitaminothérapie (B1) et surveillance en milieu hospitalier.',
      answers: [
        {'text': 'Delirium tremens (sevrage alcoolique)', 'isCorrect': true},
        {'text': 'Intoxication alcoolique aiguë', 'isCorrect': false},
        {'text': 'AVC', 'isCorrect': false},
        {'text': 'Schizophrénie', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un jeune de 20 ans arrive après une chute de 4 mètres. Il se plaint d\'une douleur dorsale intense. Quelle est votre priorité ?',
      difficulty: 'Moyen',
      explanation:
          'Traumatisme à haute cinétique avec douleur dorsale : suspicion de traumatisme rachidien. La priorité est l\'immobilisation complète du rachis (plan dur, collier cervical) avant toute mobilisation pour éviter une aggravation neurologique.',
      answers: [
        {'text': 'Immobilisation complète du rachis', 'isCorrect': true},
        {'text': 'Radiographie du dos', 'isCorrect': false},
        {'text': 'Administration d\'antalgiques', 'isCorrect': false},
        {'text': 'Examen neurologique complet', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie profonde de l\'avant-bras qui saigne en jet. Comment qualifiez-vous cette hémorragie ?',
      difficulty: 'Facile',
      explanation:
          'Une hémorragie en jet avec du sang rouge vif correspond à une hémorragie artérielle. Elle nécessite une compression directe immédiate, voire un garrot si l\'hémorragie n\'est pas contrôlable.',
      answers: [
        {'text': 'Hémorragie artérielle', 'isCorrect': true},
        {'text': 'Hémorragie veineuse', 'isCorrect': false},
        {'text': 'Hémorragie capillaire', 'isCorrect': false},
        {'text': 'Hémorragie mixte', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Une patiente de 30 ans arrive avec une douleur pelvienne intense, des métrorragies et une aménorrhée de 6 semaines. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur pelvienne + métrorragies + retard de règles évoque une grossesse extra-utérine (GEU). C\'est une urgence gynécologique pouvant se compliquer d\'hémorragie interne. Échographie pelvienne et dosage β-HCG sont nécessaires.',
      answers: [
        {'text': 'Grossesse extra-utérine', 'isCorrect': true},
        {'text': 'Fausse couche spontanée', 'isCorrect': false},
        {'text': 'Kyste ovarien', 'isCorrect': false},
        {'text': 'Infection urinaire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive inconscient. Vous constatez une odeur d\'amande amère. À quelle intoxication pensez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'L\'odeur d\'amande amère est caractéristique d\'une intoxication au cyanure. C\'est une urgence absolue nécessitant l\'administration d\'un antidote spécifique (hydroxocobalamine) et une réanimation cardio-respiratoire.',
      answers: [
        {'text': 'Intoxication au cyanure', 'isCorrect': true},
        {'text': 'Intoxication au monoxyde de carbone', 'isCorrect': false},
        {'text': 'Coma éthylique', 'isCorrect': false},
        {'text': 'Intoxication aux opiacés', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 55 ans arrive avec une hémoptysie (crachats sanglants) abondante après avoir toussé. Quelle est votre priorité ?',
      difficulty: 'Moyen',
      explanation:
          'L\'hémoptysie abondante peut compromettre les voies aériennes. La priorité est d\'assurer la liberté des voies aériennes et l\'oxygénation. Le patient doit être installé en position demi-assise côté du saignement si connu, et une fibroscopie bronchique en urgence peut être nécessaire.',
      answers: [
        {'text': 'Assurer la liberté des voies aériennes', 'isCorrect': true},
        {'text': 'Faire une radiographie thoracique', 'isCorrect': false},
        {'text': 'Administrer un antitussif', 'isCorrect': false},
        {'text': 'Prescrire un bilan de coagulation', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive après une morsure de vipère au mollet il y a 2h. Le membre est œdématié jusqu\'au genou. Quelle est votre prise en charge ?',
      difficulty: 'Moyen',
      explanation:
          'Envenimation grade 2 (œdème dépassant l\'articulation proximale). Il faut immobiliser le membre, surveiller l\'extension de l\'œdème et les signes généraux. Le sérum antivenimeux peut être indiqué. Ne jamais poser de garrot ni inciser la plaie.',
      answers: [
        {
          'text': 'Immobilisation, surveillance, éventuel sérum antivenimeux',
          'isCorrect': true
        },
        {'text': 'Pose d\'un garrot', 'isCorrect': false},
        {'text': 'Incision et aspiration du venin', 'isCorrect': false},
        {'text': 'Application de glace directe', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec des brûlures du 2e degré sur 30% de la surface corporelle suite à un incendie. Quelle est votre évaluation ?',
      difficulty: 'Moyen',
      explanation:
          'Brûlures > 20% de la surface corporelle chez l\'adulte = brûlure grave nécessitant transfert en centre de brûlés. Le patient nécessite un remplissage vasculaire important selon la formule de Parkland et une prise en charge spécialisée.',
      answers: [
        {'text': 'Brûlure grave, transfert en centre spécialisé', 'isCorrect': true},
        {'text': 'Brûlure bénigne, traitement ambulatoire', 'isCorrect': false},
        {'text': 'Brûlure modérée, hospitalisation simple', 'isCorrect': false},
        {'text': 'Brûlure superficielle, soins locaux uniquement', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 70 ans arrive avec une fièvre à 39°C, des frissons, une hypotension à 85/50 et une confusion. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Fièvre + hypotension + signes d\'hypoperfusion (confusion) = choc septique. C\'est une urgence vitale nécessitant remplissage vasculaire massif, antibiothérapie large spectre précoce et recherche du foyer infectieux.',
      answers: [
        {'text': 'Choc septique', 'isCorrect': true},
        {'text': 'Déshydratation simple', 'isCorrect': false},
        {'text': 'Grippe sévère', 'isCorrect': false},
        {'text': 'Malaise vagal', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une dyspnée sifflante, un œdème facial et un urticaire généralisé 10 minutes après une piqûre de guêpe. Quel diagnostic posez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Réaction allergique systémique rapide (< 1h) avec atteinte respiratoire et cutanée = choc anaphylactique. Urgence absolue nécessitant injection immédiate d\'adrénaline IM (0,5 mg), oxygène et surveillance.',
      answers: [
        {'text': 'Choc anaphylactique', 'isCorrect': true},
        {'text': 'Crise d\'asthme', 'isCorrect': false},
        {'text': 'Réaction locale à la piqûre', 'isCorrect': false},
        {'text': 'Urticaire simple', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur testiculaire unilatérale intense, brutale, survenue il y a 2h, avec nausées. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur testiculaire aiguë, brutale, unilatérale = torsion du cordon spermatique jusqu\'à preuve du contraire. C\'est une urgence chirurgicale (< 6h) nécessitant une détorsion pour éviter la nécrose testiculaire. Échographie-doppler et avis chirurgical urgents.',
      answers: [
        {'text': 'Torsion du cordon spermatique', 'isCorrect': true},
        {'text': 'Épididymite', 'isCorrect': false},
        {'text': 'Traumatisme testiculaire', 'isCorrect': false},
        {'text': 'Hernie inguinale', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 80 ans chute dans sa salle de bain. Il ne peut plus se relever et se plaint d\'une douleur de hanche. Quel diagnostic suspectez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Chute chez personne âgée + impossibilité de se relever + douleur de hanche = fracture du col du fémur jusqu\'à preuve du contraire. Le membre est typiquement en rotation externe et raccourci. Radiographie du bassin nécessaire.',
      answers: [
        {'text': 'Fracture du col du fémur', 'isCorrect': true},
        {'text': 'Entorse de hanche', 'isCorrect': false},
        {'text': 'Luxation de hanche', 'isCorrect': false},
        {'text': 'Hématome de hanche', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive en état d\'agitation extrême après avoir consommé de la cocaïne. Il présente une tachycardie à 150/min et une TA à 200/120. Quelle complication redoutez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'L\'intoxication à la cocaïne peut entraîner une poussée hypertensive majeure avec risque d\'AVC hémorragique, de dissection aortique ou d\'infarctus du myocarde. La prise en charge associe benzodiazépines et traitement antihypertenseur (éviter les bêta-bloquants seuls).',
      answers: [
        {'text': 'AVC hémorragique ou dissection aortique', 'isCorrect': true},
        {'text': 'Insuffisance rénale', 'isCorrect': false},
        {'text': 'Hépatite fulminante', 'isCorrect': false},
        {'text': 'Pneumonie', 'isCorrect': false},
      ],
    );

    // QUESTIONS DE TRI DES PATIENTS

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients arrivent simultanément. Lequel prenez-vous en charge en premier ?\nA) Homme 50 ans, douleur thoracique depuis 20 min, TA 130/80, FC 85\nB) Femme 65 ans, chute avec suspicion de fracture du col fémoral, TA 110/70, FC 95\nC) Enfant 2 ans, fièvre 40°C avec purpura pétéchial débutant\nD) Homme 45 ans, crise d\'asthme, SpO2 92% sous air ambiant, parle par mots',
      difficulty: 'Moyen',
      explanation:
          'Le purpura fébrile chez l\'enfant fait craindre un purpura fulminans (méningocoque) pouvant évoluer vers un choc septique en quelques heures. C\'est l\'urgence absolue nécessitant antibiotiques immédiats. La douleur thoracique stable et l\'asthme modéré sont urgents mais moins critiques.',
      answers: [
        {'text': 'C - Fièvre avec purpura pétéchial', 'isCorrect': true},
        {'text': 'A - Douleur thoracique', 'isCorrect': false},
        {'text': 'D - Crise d\'asthme modérée', 'isCorrect': false},
        {'text': 'B - Fracture col fémoral', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois patients se présentent au tri. Lequel a la priorité absolue ?\nA) Homme 35 ans, plaie du cuir chevelu qui saigne abondamment, conscient, TA 110/70, FC 105\nB) Femme 28 ans, douleur thoracique latéralisée après chute, SpO2 90%, FR 28/min, emphysème sous-cutané palpable\nC) Homme 60 ans, confusion, glycémie à 2,1 mmol/L, TA 95/65, FC 110',
      difficulty: 'Difficile',
      explanation:
          'La femme présente un probable pneumothorax suffocant (détresse respiratoire + emphysème sous-cutané + hypoxie). C\'est une urgence vitale nécessitant drainage thoracique immédiat. L\'hypoglycémie sévère (priorité 2) se corrige rapidement par resucrage IV. La plaie du cuir chevelu est impressionnante mais contrôlable.',
      answers: [
        {'text': 'B - Pneumothorax suffocant probable', 'isCorrect': true},
        {'text': 'C - Hypoglycémie sévère avec confusion', 'isCorrect': false},
        {'text': 'A - Plaie du cuir chevelu hémorragique', 'isCorrect': false},
        {'text': 'Tous à égalité', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Dans une situation d\'afflux massif de victimes, quatre patients arrivent. Lequel voyez-vous en premier ?\nA) Homme 25 ans, fracture ouverte tibiale avec hémorragie modérée, conscient, TA 100/65, FC 115\nB) Femme 45 ans, brûlures 2e degré sur 25% surface corporelle, consciente, douloureuse, TA 105/70\nC) Homme 70 ans, trauma crânien sévère, Glasgow 5, mydriase bilatérale aréactive\nD) Enfant 8 ans, plaie abdominale pénétrante, conscient mais pâle, TA 85/55, FC 130',
      difficulty: 'Difficile',
      explanation:
          'En médecine de catastrophe, on priorise les patients critiques mais sauvables. L\'enfant présente un choc hémorragique (TA basse, tachycardie) nécessitant chirurgie d\'hémostase urgente et réanimation. Le trauma crânien Glasgow 5 avec mydriase bilatérale a un pronostic très réservé (code noir en contexte de ressources limitées). Les deux autres sont urgents mais stables.',
      answers: [
        {'text': 'D - Enfant en choc hémorragique', 'isCorrect': true},
        {'text': 'B - Brûlures étendues', 'isCorrect': false},
        {'text': 'A - Fracture ouverte hémorragique', 'isCorrect': false},
        {'text': 'C - Trauma crânien grave', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Au tri des urgences, quel patient nécessite une prise en charge dans les 20 minutes maximum ?\nA) Homme 55 ans, lombosciatique droite depuis 3 jours, EVA 7/10, marche difficilement\nB) Femme 68 ans, hémiparésie gauche apparue il y a 90 minutes, TA 165/95, consciente\nC) Homme 42 ans, céphalées progressives depuis 5 jours avec photophobie, fébricule 37,8°C\nD) Femme 30 ans, vertiges rotatoires avec nausées depuis ce matin',
      difficulty: 'Moyen',
      explanation:
          'L\'AVC ischémique récent (< 4h30) est une urgence absolue nécessitant imagerie et thrombolyse potentielle ("Time is brain"). Les céphalées avec fièvre et photophobie évoquent une méningite (urgence aussi mais délai un peu plus long). La lombosciatique et les vertiges peuvent attendre.',
      answers: [
        {'text': 'B - Hémiparésie récente (suspicion AVC)', 'isCorrect': true},
        {'text': 'C - Céphalées fébriles avec photophobie', 'isCorrect': false},
        {'text': 'A - Lombosciatique hyperalgique', 'isCorrect': false},
        {'text': 'D - Vertiges rotatoires', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Cinq patients arrivent simultanément. Quel est l\'ordre de priorité correct ?\n1) Homme 35 ans, douleur thoracique constrictive depuis 45 min, sueurs, TA 110/75, troponine non faite\n2) Femme 55 ans, douleur abdominale brutale, défense généralisée, TA 100/60, FC 110\n3) Enfant 6 ans, chute de toboggan, fracture déplacée poignet, pleure, TA 95/60, FC 115\n4) Homme 28 ans, céphalées intenses brutales "coup de tonnerre", photophobie, raideur nuque, TA 155/90\n5) Femme 70 ans, demande de renouvellement anticoagulants pour FA, INR fait hier',
      difficulty: 'Difficile',
      explanation:
          'Ordre : 4 (céphalée brutale + raideur nuque = suspicion hémorragie méningée, urgence absolue) > 1 (SCA probable, thrombolyse possible) > 2 (abdomen aigu chirurgical) > 3 (fracture nécessitant réduction) > 5 (administratif). La céphalée en "coup de tonnerre" avec raideur est une urgence neurochirurgicale.',
      answers: [
        {'text': '4 > 1 > 2 > 3 > 5', 'isCorrect': true},
        {'text': '1 > 2 > 4 > 3 > 5', 'isCorrect': false},
        {'text': '2 > 1 > 4 > 3 > 5', 'isCorrect': false},
        {'text': '1 > 4 > 2 > 3 > 5', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Lors d\'un accident de la route avec 3 victimes, laquelle prenez-vous en charge en premier ?\nA) Femme 35 ans, consciente, rachialgie cervicale, mobilise les 4 membres, TA 125/80, FC 92\nB) Homme 45 ans, inconscient, Glasgow 10, pouls radial présent, FR 22/min, SpO2 91%, sang dans la bouche\nC) Adolescent 16 ans, conscient, agité, plaie du front hémorragique contrôlée, TA 115/75, FC 98',
      difficulty: 'Moyen',
      explanation:
          'La victime B présente une altération de conscience (Glasgow 10) avec probable obstruction des voies aériennes par du sang (hypoxie à 91%). La libération des voies aériennes (aspiration, position latérale de sécurité ou intubation) est une urgence vitale immédiate. Les deux autres victimes sont stables.',
      answers: [
        {'text': 'B - Victime inconsciente avec probable obstruction des VA', 'isCorrect': true},
        {'text': 'A - Rachialgie cervicale', 'isCorrect': false},
        {'text': 'C - Plaie hémorragique contrôlée', 'isCorrect': false},
        {'text': 'Toutes en même temps', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients en salle d\'attente. Lequel nécessite une réévaluation prioritaire ?\nA) Homme 30 ans, entorse cheville depuis 3h, douleur 6/10, œdème modéré, déambule avec difficulté\nB) Femme 25 ans, arrivée il y a 15 min pour gastro-entérite, devient progressivement pâle et somnolente, ne répond plus aux questions de façon cohérente\nC) Homme 55 ans, attendant depuis 1h pour certificat AT suite à lombosciatique chronique connue\nD) Enfant 4 ans, arrivé il y a 30 min, plaie du menton à suturer de 2 cm, saignement contrôlé, joue calmement',
      difficulty: 'Moyen',
      explanation:
          'La détérioration neurologique aiguë (somnolence, incohérence) chez la patiente B évoque un choc (hypovolémique probable vu le contexte de gastro-entérite) ou une hypoglycémie sévère. C\'est une urgence vitale nécessitant réévaluation immédiate, constantes vitales et prise en charge en salle de déchoquage. Les autres patients sont stables.',
      answers: [
        {'text': 'B - Patiente qui se détériore neurologiquement', 'isCorrect': true},
        {'text': 'A - Entorse attendant depuis 3h', 'isCorrect': false},
        {'text': 'C - Demande de certificat', 'isCorrect': false},
        {'text': 'D - Plaie à suturer', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'En cas d\'attentat avec nombreuses victimes, comment classer un patient conscient, qui marche, avec une plaie du bras ?',
      difficulty: 'Moyen',
      explanation:
          'Un patient qui peut marcher et parler normalement est classé en urgence relative (code jaune) ou mineure (code vert) selon la gravité de la plaie. Il n\'est pas en danger vital immédiat et peut attendre la prise en charge des patients en code rouge.',
      answers: [
        {'text': 'Urgence relative (jaune) ou mineure (vert)', 'isCorrect': true},
        {'text': 'Urgence absolue (rouge)', 'isCorrect': false},
        {'text': 'Décédé (noir/bleu)', 'isCorrect': false},
        {'text': 'Urgence dépassée (gris)', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Parmi ces patients, lequel attribuez-vous au code ROUGE (urgence absolue) ?\nA) Femme 40 ans, crise d\'asthme, SpO2 94%, FR 26/min, parle par phrases courtes, sibilants diffus\nB) Homme 60 ans, chute avec déformation de la jambe, douleur 8/10, TA 135/85, FC 88\nC) Enfant 8 ans, otite avec fièvre 39,2°C, pleure, conscience normale\nD) Femme 72 ans, malaise avec palpitations, TA 95/60, FC 165 irrégulière, sueurs, pâleur',
      difficulty: 'Moyen',
      explanation:
          'La femme de 72 ans présente probablement une tachycardie irrégulière rapide (fibrillation auriculaire rapide ou autre trouble du rythme) avec signes de mauvaise tolérance hémodynamique (hypotension, sueurs, pâleur). C\'est un code rouge nécessitant monitoring, ECG et traitement antiarythmique urgent. L\'asthme est modéré (SpO2 94%), la fracture stable, l\'otite bénigne.',
      answers: [
        {'text': 'D - Tachycardie mal tolérée avec hypotension', 'isCorrect': true},
        {'text': 'A - Crise d\'asthme modérée', 'isCorrect': false},
        {'text': 'B - Fracture de jambe', 'isCorrect': false},
        {'text': 'C - Otite fébrile', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois enfants arrivent après avoir mangé des champignons il y a 8h. Lequel évaluez-vous en premier ?\nA) Enfant 10 ans, asymptomatique, parents très inquiets\nB) Enfant 6 ans, douleurs abdominales modérées, vomissements x3, conscient, TA 100/65, FC 105\nC) Enfant 4 ans, diarrhée profuse sanglante depuis 2h, vomissements incoercibles, pâle, TA 75/50, FC 145, temps de recoloration > 3 sec',
      difficulty: 'Moyen',
      explanation:
          'L\'enfant C présente un choc hypovolémique (TA basse, tachycardie, TRC > 3 sec, pâleur) lié à une gastro-entérite hémorragique sévère. C\'est l\'urgence absolue nécessitant remplissage vasculaire immédiat et surveillance en réanimation. L\'enfant B a des symptômes modérés nécessitant surveillance. L\'enfant A est asymptomatique (période de latence possible avec certains champignons donc surveillance nécessaire mais pas urgente).',
      answers: [
        {'text': 'C - Enfant en choc hypovolémique', 'isCorrect': true},
        {'text': 'B - Douleurs abdominales et vomissements', 'isCorrect': false},
        {'text': 'A - Asymptomatique', 'isCorrect': false},
        {'text': 'Les trois en même temps', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une détresse respiratoire aiguë. Quel signe indique une gravité extrême nécessitant une intubation immédiate ?',
      difficulty: 'Difficile',
      explanation:
          'Le silence auscultatoire (absence de bruits respiratoires) dans un contexte de détresse respiratoire signe un épuisement respiratoire avec arrêt ventilatoire imminent. C\'est une indication d\'intubation en extrême urgence.',
      answers: [
        {'text': 'Silence auscultatoire (thorax muet)', 'isCorrect': true},
        {'text': 'Sibilants diffus', 'isCorrect': false},
        {'text': 'Toux productive', 'isCorrect': false},
        {'text': 'Légère polypnée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient polytraumatisé arrive après un AVP. Quelle lésion nécessite un geste d\'hémostase en extrême urgence ?',
      difficulty: 'Moyen',
      explanation:
          'Une hémorragie externe en jet nécessite une compression immédiate voire un garrot si elle ne peut être contrôlée. C\'est une urgence vitale immédiate car la mort peut survenir en quelques minutes par choc hémorragique.',
      answers: [
        {'text': 'Hémorragie externe en jet du membre inférieur', 'isCorrect': true},
        {'text': 'Fracture fermée du poignet', 'isCorrect': false},
        {'text': 'Plaie superficielle du cuir chevelu', 'isCorrect': false},
        {'text': 'Hématome de la cuisse', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Une femme accouche aux urgences. Le bébé est né mais ne respire pas et est tout mou. Que faites-vous en premier ?',
      difficulty: 'Moyen',
      explanation:
          'Un nouveau-né qui ne respire pas nécessite immédiatement une stimulation (séchage vigoureux) puis si inefficace, des insufflations au masque. La réanimation néonatale doit commencer dans les 60 premières secondes de vie ("golden minute").',
      answers: [
        {'text': 'Stimulation et ventilation au masque', 'isCorrect': true},
        {'text': 'Massage cardiaque immédiat', 'isCorrect': false},
        {'text': 'Appeler le pédiatre', 'isCorrect': false},
        {'text': 'Clamper le cordon', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive après avoir été retrouvé dans une voiture fermée avec le moteur allumé. Il est confus et céphalalgique. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Confusion + céphalées dans une atmosphère confinée avec combustion évoque une intoxication au monoxyde de carbone (CO). C\'est une urgence nécessitant oxygénothérapie normobare voire hyperbare selon le taux de carboxyhémoglobine.',
      answers: [
        {'text': 'Intoxication au monoxyde de carbone', 'isCorrect': true},
        {'text': 'AVC ischémique', 'isCorrect': false},
        {'text': 'Crise de migraine', 'isCorrect': false},
        {'text': 'Déshydratation', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient sous anticoagulants arrive après un traumatisme crânien mineur il y a 6h. Il devient progressivement confus. Quelle complication suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Tout traumatisme crânien chez un patient anticoagulé doit faire craindre un hématome intracrânien, même si le traumatisme semble mineur. La confusion progressive signe l\'effet de masse. Scanner cérébral en urgence indispensable.',
      answers: [
        {'text': 'Hématome intracrânien', 'isCorrect': true},
        {'text': 'Simple commotion cérébrale', 'isCorrect': false},
        {'text': 'Désorientation post-traumatique bénigne', 'isCorrect': false},
        {'text': 'Crise d\'épilepsie', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient diabétique de type 1 arrive nauséeux, avec une respiration ample et rapide (Kussmaul) et une haleine "pomme verte". Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Diabétique type 1 + respiration de Kussmaul (polypnée ample) + haleine cétonique = acidocétose diabétique. C\'est une urgence métabolique nécessitant réhydratation, insulinothérapie IV et correction des troubles hydro-électrolytiques.',
      answers: [
        {'text': 'Acidocétose diabétique', 'isCorrect': true},
        {'text': 'Hypoglycémie sévère', 'isCorrect': false},
        {'text': 'Gastro-entérite', 'isCorrect': false},
        {'text': 'Pneumonie', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 18 mois arrive avec une détresse respiratoire aiguë, un tirage sus-sternal et un stridor inspiratoire après avoir mangé des cacahuètes. Que suspectez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Détresse respiratoire aiguë + stridor inspiratoire + contexte d\'ingestion alimentaire chez jeune enfant = corps étranger des voies aériennes. C\'est une urgence vitale pouvant nécessiter manœuvres de désobstruction ou extraction en urgence.',
      answers: [
        {'text': 'Corps étranger des voies aériennes', 'isCorrect': true},
        {'text': 'Laryngite aiguë', 'isCorrect': false},
        {'text': 'Crise d\'asthme', 'isCorrect': false},
        {'text': 'Bronchiolite', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 35 ans arrive agité avec mydriase bilatérale, tachycardie à 140/min, hypertension et hyperthermie à 39°C. Il avoue avoir pris de l\'ecstasy. Quelle complication grave craignez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'L\'intoxication à l\'ecstasy/MDMA peut entraîner un syndrome sérotoninergique avec hyperthermie maligne (> 40°C), pouvant évoluer vers défaillance multiviscérale, rhabdomyolyse et décès. Refroidissement externe et benzodiazépines sont urgents.',
      answers: [
        {'text': 'Hyperthermie maligne avec défaillance multi-viscérale', 'isCorrect': true},
        {'text': 'Hypothermie', 'isCorrect': false},
        {'text': 'Bradycardie sévère', 'isCorrect': false},
        {'text': 'Hypoglycémie', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie de l\'abdomen par arme blanche. Vous observez une extériorisation de l\'intestin. Que faites-vous ?',
      difficulty: 'Moyen',
      explanation:
          'En cas d\'éviscération traumatique, il ne faut JAMAIS réintégrer les viscères. Il faut les recouvrir d\'un champ stérile humide (sérum physiologique), assurer la stabilité hémodynamique et avis chirurgical en extrême urgence.',
      answers: [
        {'text': 'Recouvrir avec un champ stérile humide, ne pas réintégrer', 'isCorrect': true},
        {'text': 'Réintégrer immédiatement l\'intestin', 'isCorrect': false},
        {'text': 'Suturer la plaie directement', 'isCorrect': false},
        {'text': 'Appliquer un pansement sec compressif', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Lors d\'un tri en catastrophe, comment classez-vous un patient inconscient en arrêt respiratoire sans pouls, dans un contexte de ressources limitées ?',
      difficulty: 'Difficile',
      explanation:
          'En médecine de catastrophe avec moyens limités, les patients en arrêt cardio-respiratoire sont classés "dépassés" (code noir) car la réanimation mobiliserait trop de ressources au détriment de patients sauvables. C\'est un choix éthique difficile du triage de catastrophe.',
      answers: [
        {'text': 'Urgence dépassée (noir)', 'isCorrect': true},
        {'text': 'Urgence absolue (rouge)', 'isCorrect': false},
        {'text': 'Urgence relative (jaune)', 'isCorrect': false},
        {'text': 'Urgence mineure (vert)', 'isCorrect': false},
      ],
    );

    // NOUVELLES QUESTIONS SUPPLÉMENTAIRES (50 de plus)

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 50 ans arrive avec une douleur intense dans le mollet gauche, apparue brutalement. Il présente un œdème et la jambe est chaude. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur + œdème + chaleur du mollet évoque une thrombose veineuse profonde (phlébite). C\'est une urgence car elle peut se compliquer d\'embolie pulmonaire. Échographie-doppler veineux et dosage D-dimères sont nécessaires.',
      answers: [
        {'text': 'Thrombose veineuse profonde (phlébite)', 'isCorrect': true},
        {'text': 'Déchirure musculaire', 'isCorrect': false},
        {'text': 'Crampe musculaire', 'isCorrect': false},
        {'text': 'Arthrite du genou', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 2 ans arrive avec une toux rauque (aboyante), un stridor inspiratoire et une fièvre modérée depuis 2 jours. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Toux aboyante + stridor inspiratoire + contexte viral = laryngite aiguë (croup). Traitement : corticoïdes et nébulisation d\'adrénaline si détresse respiratoire. Surveiller l\'aggravation vers une épiglottite.',
      answers: [
        {'text': 'Laryngite aiguë (croup)', 'isCorrect': true},
        {'text': 'Bronchiolite', 'isCorrect': false},
        {'text': 'Pneumonie', 'isCorrect': false},
        {'text': 'Corps étranger', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 40 ans arrive avec une douleur oculaire intense, une rougeur, une vision floue et des halos autour des lumières. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur oculaire + rougeur + baisse d\'acuité + halos colorés = glaucome aigu par fermeture de l\'angle. C\'est une urgence ophtalmologique nécessitant traitement hypotonisant immédiat (Diamox, collyres) pour éviter la cécité.',
      answers: [
        {'text': 'Glaucome aigu par fermeture de l\'angle', 'isCorrect': true},
        {'text': 'Conjonctivite', 'isCorrect': false},
        {'text': 'Migraine ophtalmique', 'isCorrect': false},
        {'text': 'Uvéite', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient présente une plaie du thorax qui "souffle" avec la respiration. Quel diagnostic posez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Une plaie thoracique soufflante indique une communication entre la cavité pleurale et l\'extérieur (plaie pénétrante). Risque de pneumothorax ouvert. Il faut poser un pansement occlusif trois côtés (valve unidirectionnelle) et drainage pleural.',
      answers: [
        {'text': 'Plaie thoracique soufflante (pneumothorax ouvert)', 'isCorrect': true},
        {'text': 'Contusion pulmonaire', 'isCorrect': false},
        {'text': 'Fracture de côte simple', 'isCorrect': false},
        {'text': 'Hémothorax', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 25 ans arrive avec une douleur intense au niveau du flanc droit irradiant vers les organes génitaux, avec des nausées. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Douleur intense du flanc irradiant vers les organes génitaux = colique néphrétique (lithiase urinaire). Diagnostic par bandelette urinaire (hématurie) et échographie/scanner. Traitement antalgique et anti-inflammatoire.',
      answers: [
        {'text': 'Colique néphrétique', 'isCorrect': true},
        {'text': 'Appendicite', 'isCorrect': false},
        {'text': 'Occlusion intestinale', 'isCorrect': false},
        {'text': 'Hernie étranglée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un traumatisme de l\'œil par projection de produit chimique (soude). Quelle est votre priorité absolue ?',
      difficulty: 'Facile',
      explanation:
          'Brûlure chimique oculaire = urgence absolue ! La priorité est le rinçage abondant et prolongé au sérum physiologique (15-30 min) AVANT tout autre examen. Chaque seconde compte pour limiter les lésions cornéennes irréversibles.',
      answers: [
        {'text': 'Rinçage oculaire abondant immédiat', 'isCorrect': true},
        {'text': 'Mesure du pH oculaire', 'isCorrect': false},
        {'text': 'Examen ophtalmologique complet', 'isCorrect': false},
        {'text': 'Application d\'une pommade antibiotique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 60 ans arrive avec une paralysie faciale périphérique brutale. Il ne peut plus fermer l\'œil et la bouche dévie. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Paralysie faciale périphérique aiguë (tout le visage atteint) = paralysie de Bell (a frigore) dans 70% des cas. Mais il faut éliminer un AVC (paralysie centrale = partie inférieure uniquement). Protection cornéenne indispensable.',
      answers: [
        {'text': 'Paralysie faciale périphérique (a frigore)', 'isCorrect': true},
        {'text': 'AVC ischémique', 'isCorrect': false},
        {'text': 'Tumeur cérébrale', 'isCorrect': false},
        {'text': 'Sclérose en plaques', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une hémorragie digestive haute (hématémèse). Quelle position adoptez-vous ?',
      difficulty: 'Facile',
      explanation:
          'En cas d\'hématémèse, position demi-assise pour éviter l\'inhalation bronchique. Voie veineuse de gros calibre, remplissage vasculaire, bilan et fibroscopie digestive en urgence. Surveiller état hémodynamique.',
      answers: [
        {'text': 'Position demi-assise', 'isCorrect': true},
        {'text': 'Décubitus dorsal strict', 'isCorrect': false},
        {'text': 'Position latérale de sécurité', 'isCorrect': false},
        {'text': 'Position de Trendelenburg', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient diabétique arrive avec des douleurs abdominales, des vomissements et une glycémie à 5 g/L. Son haleine sent la pomme. Que redoutez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Hyperglycémie majeure (> 3 g/L) + douleurs abdominales + haleine cétonique = acidocétose diabétique. Urgence métabolique avec risque de coma et décès. Réhydratation, insulinothérapie IV et correction des troubles électrolytiques.',
      answers: [
        {'text': 'Acidocétose diabétique', 'isCorrect': true},
        {'text': 'Pancréatite aiguë', 'isCorrect': false},
        {'text': 'Occlusion intestinale', 'isCorrect': false},
        {'text': 'Gastro-entérite', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 70 ans arrive confus avec une température à 35°C, une bradycardie et une hypotension. Il a été retrouvé inconscient chez lui. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Hypothermie (< 35°C) + confusion + bradycardie = hypothermie sévère. Risque d\'arrêt cardiaque sur fibrillation ventriculaire. Réchauffement progressif externe puis interne si nécessaire. Ne pas déclarer décès avant réchauffement.',
      answers: [
        {'text': 'Hypothermie sévère', 'isCorrect': true},
        {'text': 'AVC', 'isCorrect': false},
        {'text': 'Infarctus du myocarde', 'isCorrect': false},
        {'text': 'Sepsis', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un traumatisme du genou. Vous constatez une déformation et l\'absence de pouls pédieux. Quelle complication craignez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Traumatisme du genou + déformation + abolition des pouls distaux = luxation du genou avec lésion vasculaire (artère poplitée). Urgence absolue : réduction immédiate, contrôle vasculaire et écho-doppler. Risque d\'ischémie et amputation.',
      answers: [
        {'text': 'Lésion de l\'artère poplitée avec ischémie', 'isCorrect': true},
        {'text': 'Fracture simple du fémur', 'isCorrect': false},
        {'text': 'Entorse bénigne', 'isCorrect': false},
        {'text': 'Lésion méniscale', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur épigastrique transfixiante (en coup de poignard), irradiant dans le dos. Il a des antécédents de pancréatite. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur épigastrique transfixiante + antécédents de pancréatite = pancréatite aiguë récidivante. Dosage lipase (> 3N), scanner abdominal. Recherche étiologie (lithiase biliaire, alcool). Prise en charge : jeûne, antalgie, réanimation si sévère.',
      answers: [
        {'text': 'Pancréatite aiguë', 'isCorrect': true},
        {'text': 'Infarctus du myocarde', 'isCorrect': false},
        {'text': 'Ulcère gastrique perforé', 'isCorrect': false},
        {'text': 'Colique hépatique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Cinq patients arrivent simultanément. Lequel voyez-vous en DERNIER ?\nA) Homme 30 ans, plaie suturée qui cicatrise bien\nB) Femme 50 ans, douleur thoracique\nC) Enfant convulsif\nD) Patient en choc hémorragique',
      difficulty: 'Facile',
      explanation:
          'Le patient avec plaie cicatrisante (contrôle post-opératoire) est le moins urgent. Les trois autres sont des urgences vitales : douleur thoracique (SCA ?), convulsions (état de mal ?) et choc hémorragique nécessitent prise en charge immédiate.',
      answers: [
        {'text': 'A - Contrôle de plaie cicatrisante', 'isCorrect': true},
        {'text': 'B - Douleur thoracique', 'isCorrect': false},
        {'text': 'C - Enfant convulsif', 'isCorrect': false},
        {'text': 'D - Choc hémorragique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une céphalée brutale en "coup de tonnerre", la pire de sa vie. Il n\'a pas de déficit neurologique. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Céphalée brutale et maximale d\'emblée (coup de tonnerre) = hémorragie méningée jusqu\'à preuve du contraire. Scanner cérébral en urgence puis PL si scanner négatif. Recherche anévrisme. Pronostic vital et fonctionnel engagé.',
      answers: [
        {'text': 'Hémorragie méningée (rupture d\'anévrisme)', 'isCorrect': true},
        {'text': 'Migraine sévère', 'isCorrect': false},
        {'text': 'Méningite', 'isCorrect': false},
        {'text': 'Sinusite aiguë', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 85 ans arrive avec une fibrillation atriale rapide à 160/min découverte aux urgences. Il est asymptomatique. Quelle complication redoutez-vous le plus ?',
      difficulty: 'Moyen',
      explanation:
          'La fibrillation atriale expose au risque d\'AVC embolique par formation de thrombus intra-auriculaire. Un traitement anticoagulant est nécessaire selon le score CHA2DS2-VASc. Le ralentissement de la fréquence est aussi important.',
      answers: [
        {'text': 'AVC embolique', 'isCorrect': true},
        {'text': 'Infarctus du myocarde', 'isCorrect': false},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
        {'text': 'Insuffisance rénale', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un épistaxis (saignement de nez) abondant depuis 30 minutes qui ne s\'arrête pas. Quelle est votre première action ?',
      difficulty: 'Facile',
      explanation:
          'Épistaxis : compression bidigitale des ailes du nez pendant 10 minutes, tête penchée en avant (pas en arrière !). Si échec : méchage antérieur. Rechercher cause (HTA, anticoagulants, traumatisme). Surveillance hémodynamique.',
      answers: [
        {'text': 'Compression bidigitale du nez, tête en avant', 'isCorrect': true},
        {'text': 'Tête en arrière', 'isCorrect': false},
        {'text': 'Méchage nasal immédiat', 'isCorrect': false},
        {'text': 'Tamponnement postérieur', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 20 ans arrive essoufflé après un match de foot. Il est grand et mince. Il présente une douleur thoracique et une dyspnée. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Jeune patient longiligne + douleur thoracique brutale + dyspnée = pneumothorax spontané idiopathique. Radiographie thoracique en urgence. Drainage pleural si pneumothorax complet ou mal toléré.',
      answers: [
        {'text': 'Pneumothorax spontané', 'isCorrect': true},
        {'text': 'Infarctus du myocarde', 'isCorrect': false},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
        {'text': 'Asthme d\'effort', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient sous AVK (anticoagulants) arrive avec un INR à 8 et une épistaxis mineure. Quelle est votre prise en charge ?',
      difficulty: 'Difficile',
      explanation:
          'Surdosage en AVK avec INR > 6 et saignement mineur : arrêt temporaire AVK + vitamine K per os à faible dose. Surveillance INR. Si hémorragie majeure : CCP (concentré de complexe prothrombinique) + vitamine K IV.',
      answers: [
        {'text': 'Arrêt AVK + vitamine K per os', 'isCorrect': true},
        {'text': 'Continuer AVK normalement', 'isCorrect': false},
        {'text': 'Transfusion de plasma frais congelé', 'isCorrect': false},
        {'text': 'Augmenter la dose d\'AVK', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur scrotale et une bourse très augmentée de volume, indolore à la transillumination. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Grosse bourse indolore + transillumination positive (la lumière passe) = hydrocèle ou kyste de l\'épididyme. Si transillumination négative : hernie, tumeur ou hématocèle. La torsion testiculaire est douloureuse et aiguë.',
      answers: [
        {'text': 'Hydrocèle', 'isCorrect': true},
        {'text': 'Torsion testiculaire', 'isCorrect': false},
        {'text': 'Orchite', 'isCorrect': false},
        {'text': 'Cancer du testicule', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients pédiatriques arrivent. Lequel présente le plus grand risque vital immédiat ?\nA) Nourrisson 6 mois, fièvre 39°C, pleure\nB) Enfant 2 ans, purpura fébrile extensif\nC) Enfant 5 ans, otite aiguë\nD) Enfant 8 ans, entorse de cheville',
      difficulty: 'Moyen',
      explanation:
          'Purpura fébrile chez l\'enfant = purpura fulminans (méningococcémie) jusqu\'à preuve du contraire. Urgence absolue : antibiothérapie immédiate (ceftriaxone) avant tout examen. Pronostic vital engagé (choc septique, méningite).',
      answers: [
        {'text': 'B - Purpura fébrile', 'isCorrect': true},
        {'text': 'A - Fièvre isolée', 'isCorrect': false},
        {'text': 'C - Otite aiguë', 'isCorrect': false},
        {'text': 'D - Entorse', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une luxation antérieure de l\'épaule après une chute. Que devez-vous vérifier AVANT toute manœuvre de réduction ?',
      difficulty: 'Moyen',
      explanation:
          'Avant réduction d\'une luxation d\'épaule : vérifier la sensibilité du territoire du nerf axillaire (moignon de l\'épaule) et la motricité du deltoïde. Puis radiographie pour éliminer fracture associée. Réduction sous analgésie.',
      answers: [
        {'text': 'Sensibilité et motricité (nerf axillaire)', 'isCorrect': true},
        {'text': 'Tension artérielle', 'isCorrect': false},
        {'text': 'Glycémie capillaire', 'isCorrect': false},
        {'text': 'État de conscience', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive après ingestion massive de paracétamol (20g) il y a 3h dans un but suicidaire. Quel antidote administrez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Intoxication au paracétamol : l\'antidote est la N-acétylcystéine (NAC) en IV, efficace surtout si débuté avant 8h. Dosage paracétamolémie à H4. Risque de cytolyse hépatique fulminante à J2-J3. Surveillance biologique.',
      answers: [
        {'text': 'N-acétylcystéine (NAC)', 'isCorrect': true},
        {'text': 'Flumazénil', 'isCorrect': false},
        {'text': 'Naloxone', 'isCorrect': false},
        {'text': 'Hydroxocobalamine', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec des convulsions qui durent depuis 10 minutes sans reprise de conscience. Comment appelez-vous cette situation ?',
      difficulty: 'Facile',
      explanation:
          'Convulsions > 5 minutes sans reprise de conscience = état de mal épileptique. Urgence vitale nécessitant benzodiazépines IV/IR (diazépam, clonazépam), protection des voies aériennes, oxygénation. Si échec : antiépileptiques de 2e ligne.',
      answers: [
        {'text': 'État de mal épileptique', 'isCorrect': true},
        {'text': 'Crise convulsive simple', 'isCorrect': false},
        {'text': 'Syncope prolongée', 'isCorrect': false},
        {'text': 'Accident ischémique transitoire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une rétention aiguë d\'urine (globe vésical). Il n\'a pas uriné depuis 24h et a des douleurs hypogastriques. Que faites-vous ?',
      difficulty: 'Facile',
      explanation:
          'Rétention aiguë d\'urine : sondage vésical évacuateur en urgence pour soulager le patient. Attention à l\'hématurie ex vacuo si évacuation trop rapide. Rechercher cause : hypertrophie prostatique, obstacle urétral, neurologique.',
      answers: [
        {'text': 'Sondage vésical évacuateur', 'isCorrect': true},
        {'text': 'Antibiotiques oraux', 'isCorrect': false},
        {'text': 'Attendre miction spontanée', 'isCorrect': false},
        {'text': 'Diurétiques IV', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois patients arrivent après un accident de voiture. Lequel priorisez-vous ?\nA) Patient avec fracture ouverte du tibia, saignement modéré\nB) Patient confus, TA 80/50, FC 130\nC) Patient conscient avec douleur cervicale',
      difficulty: 'Moyen',
      explanation:
          'Le patient confus en état de choc (hypotension + tachycardie) est en danger vital immédiat. Il nécessite remplissage vasculaire urgent et recherche source hémorragique. Les deux autres sont stables.',
      answers: [
        {'text': 'B - Patient en état de choc', 'isCorrect': true},
        {'text': 'A - Fracture ouverte', 'isCorrect': false},
        {'text': 'C - Douleur cervicale', 'isCorrect': false},
        {'text': 'Tous en même temps', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie par morsure de chien à la main datant de 2h. Quelle est votre prise en charge ?',
      difficulty: 'Moyen',
      explanation:
          'Morsure : lavage abondant eau + savon, parage chirurgical si nécessaire, antibiothérapie (Augmentin) car risque infectieux élevé (Pasteurella). Vérifier vaccination antitétanique. Ne pas suturer les morsures de mains (risque d\'abcès).',
      answers: [
        {'text': 'Lavage, parage, antibiotiques, pas de suture', 'isCorrect': true},
        {'text': 'Suture immédiate sans antibiotiques', 'isCorrect': false},
        {'text': 'Pansement simple sans traitement', 'isCorrect': false},
        {'text': 'Amputation préventive', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 30 ans arrive avec une diarrhée sanglante, des douleurs abdominales et une fièvre depuis 3 jours après un voyage en Asie. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Diarrhée sanglante + fièvre + contexte de voyage = dysenterie (Shigella, amibiase, Campylobacter). Coproculture, recherche parasites. Hydratation, antibiothérapie selon germe. Isolement contact si nosocomial.',
      answers: [
        {'text': 'Dysenterie infectieuse', 'isCorrect': true},
        {'text': 'Gastro-entérite virale simple', 'isCorrect': false},
        {'text': 'Appendicite', 'isCorrect': false},
        {'text': 'Intoxication alimentaire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un malaise, une sensation de mort imminente, des palpitations et une dyspnée. ECG et examens normaux. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Malaise + sensation de mort imminente + palpitations/dyspnée avec examens normaux = attaque de panique (crise d\'angoisse aiguë). Rassurer le patient, anxiolytiques si besoin. Mais toujours éliminer urgence somatique d\'abord.',
      answers: [
        {'text': 'Attaque de panique', 'isCorrect': true},
        {'text': 'Infarctus du myocarde', 'isCorrect': false},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
        {'text': 'Pneumothorax', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un traumatisme du bassin après AVP à haute vitesse. Il présente une instabilité pelvienne et une hypotension. Quelle complication craignez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Fracture instable du bassin à haute cinétique = risque d\'hémorragie rétro-péritonéale massive (artères iliaques, plexus veineux). Urgence absolue : remplissage, transfusion, compression pelvienne (ceinture), artériographie ± embolisation.',
      answers: [
        {'text': 'Hémorragie rétro-péritonéale massive', 'isCorrect': true},
        {'text': 'Lésion intestinale', 'isCorrect': false},
        {'text': 'Fracture du fémur', 'isCorrect': false},
        {'text': 'Thrombose veineuse', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 55 ans arrive avec des vertiges rotatoires intenses, des nausées et un nystagmus horizontal. Pas de déficit neurologique. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Vertige rotatoire aigu + nystagmus sans déficit = vertige périphérique (vestibulaire) : névrite vestibulaire ou VPPB. Si déficit associé : AVC du tronc cérébral. Examen : Halmagyi, Dix-Hallpike. Traitement symptomatique.',
      answers: [
        {'text': 'Vertige périphérique (névrite vestibulaire)', 'isCorrect': true},
        {'text': 'AVC du tronc cérébral', 'isCorrect': false},
        {'text': 'Tumeur cérébrale', 'isCorrect': false},
        {'text': 'Hypoglycémie', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un nourrisson de 3 mois arrive avec des vomissements en jet après chaque biberon et un amaigrissement. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Nourrisson 3-6 semaines + vomissements en jet non bilieux + amaigrissement = sténose hypertrophique du pylore. Palpation : olive pylorique. Échographie. Traitement chirurgical (pylorotomie). Correction déshydratation/alcalose avant.',
      answers: [
        {'text': 'Sténose hypertrophique du pylore', 'isCorrect': true},
        {'text': 'Reflux gastro-œsophagien', 'isCorrect': false},
        {'text': 'Gastro-entérite', 'isCorrect': false},
        {'text': 'Invagination intestinale', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Deux patients arrivent simultanément. Lequel voyez-vous en premier ?\nA) Patient 70 ans, dyspnée + orthopnée + œdème membres inférieurs\nB) Patient 25 ans, consultation pour certificat sport',
      difficulty: 'Facile',
      explanation:
          'Patient A présente des signes d\'insuffisance cardiaque décompensée (dyspnée, orthopnée, OMI) = urgence nécessitant oxygène, diurétiques, bilan. Le certificat sportif peut attendre.',
      answers: [
        {'text': 'A - Décompensation cardiaque', 'isCorrect': true},
        {'text': 'B - Certificat sportif', 'isCorrect': false},
        {'text': 'Les deux en même temps', 'isCorrect': false},
        {'text': 'B puis A', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur du mollet après un long voyage en avion. Échographie : thrombose veineuse profonde confirmée. Quel traitement instaurez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'TVP confirmée : anticoagulation immédiate ! HBPM en sous-cutané ou AOD per os. Relais AVK si choisi. Durée minimale 3 mois. Recherche néoplasie occulte si non provoquée. Bas de contention. Prévention embolie pulmonaire.',
      answers: [
        {'text': 'Anticoagulation immédiate (HBPM ou AOD)', 'isCorrect': true},
        {'text': 'Anti-inflammatoires seulement', 'isCorrect': false},
        {'text': 'Repos strict sans traitement', 'isCorrect': false},
        {'text': 'Aspirin simple dose', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie profonde à la cuisse par objet rouillé il y a 6h. Il n\'est pas vacciné contre le tétanos. Quelle est votre prise en charge ?',
      difficulty: 'Moyen',
      explanation:
          'Plaie tétanigène + non vacciné : immunoglobulines antitétaniques (sérothérapie) + vaccination (Dt-Polio) en sites différents. Parage chirurgical de la plaie. Antibioprophylaxie. Rappel vaccinal à 1 et 6-12 mois.',
      answers: [
        {'text': 'Immunoglobulines + vaccination immédiate', 'isCorrect': true},
        {'text': 'Vaccination seule', 'isCorrect': false},
        {'text': 'Antibiotiques seuls', 'isCorrect': false},
        {'text': 'Aucun traitement nécessaire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 40 ans arrive avec une douleur lombaire aiguë invalidante après avoir soulevé une charge. Pas de déficit neurologique. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Lombalgie aiguë mécanique après effort sans signe de gravité (pas de déficit, pas de syndrome de la queue de cheval, pas de fièvre) = lumbago. Traitement : repos relatif, antalgiques, AINS. Pas d\'imagerie en urgence.',
      answers: [
        {'text': 'Lombalgie aiguë commune (lumbago)', 'isCorrect': true},
        {'text': 'Hernie discale avec compression', 'isCorrect': false},
        {'text': 'Fracture vertébrale', 'isCorrect': false},
        {'text': 'Spondylodiscite', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 6 mois arrive avec des pleurs inconsolables, des selles glairo-sanglantes ("gelée de groseille") et des douleurs abdominales paroxystiques. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Nourrisson 6-9 mois + douleurs paroxystiques + selles glairo-sanglantes = invagination intestinale aiguë. Boudin d\'invagination palpable. Échographie. Traitement : lavement aux hydrosolubles ± chirurgie si échec/complications.',
      answers: [
        {'text': 'Invagination intestinale aiguë', 'isCorrect': true},
        {'text': 'Gastro-entérite', 'isCorrect': false},
        {'text': 'Appendicite', 'isCorrect': false},
        {'text': 'Colique du nourrisson', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un œil rouge, douloureux, avec baisse d\'acuité visuelle et photophobie. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Œil rouge + douleur + BAV + photophobie = uvéite antérieure (iridocyclite) ou kératite. Urgence ophtalmologique. Examen à la lampe à fente. Si conjonctivite simple : pas de BAV ni photophobie marquée.',
      answers: [
        {'text': 'Uvéite antérieure ou kératite', 'isCorrect': true},
        {'text': 'Conjonctivite banale', 'isCorrect': false},
        {'text': 'Hémorragie sous-conjonctivale', 'isCorrect': false},
        {'text': 'Sécheresse oculaire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients en salle d\'attente. Lequel réévaluez-vous en PRIORITÉ ?\nA) Patient stable attendant radio pour entorse\nB) Patient qui devient subitement pâle, confus, avec TA à 70/40\nC) Patient attendant résultats de prise de sang\nD) Patient attendant certificat',
      difficulty: 'Facile',
      explanation:
          'Toute détérioration hémodynamique en salle d\'attente (pâleur + confusion + hypotension = état de choc) nécessite réévaluation immédiate et prise en charge urgente. Risque vital engagé.',
      answers: [
        {'text': 'B - Détérioration avec état de choc', 'isCorrect': true},
        {'text': 'A - Entorse stable', 'isCorrect': false},
        {'text': 'C - Attente résultats', 'isCorrect': false},
        {'text': 'D - Certificat', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 60 ans arrive avec une douleur à la jambe, un mollet chaud, rouge et œdématié. Il a des antécédents de cancer. Quels examens demandez-vous en urgence ?',
      difficulty: 'Moyen',
      explanation:
          'Suspicion de TVP (facteur de risque = cancer) : échographie-doppler veineux en urgence + dosage D-dimères. Si TVP confirmée : recherche EP associée (angio-scanner si signes cliniques). Anticoagulation immédiate.',
      answers: [
        {'text': 'Échographie-doppler veineux + D-dimères', 'isCorrect': true},
        {'text': 'Radiographie simple de la jambe', 'isCorrect': false},
        {'text': 'IRM du membre inférieur', 'isCorrect': false},
        {'text': 'Aucun examen, traitement d\'épreuve', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 35 ans arrive avec une douleur anale intense, battante, avec tuméfaction bleutée à l\'inspection. Quel diagnostic posez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Douleur anale intense + tuméfaction bleutée = thrombose hémorroïdaire externe. Traitement : excision sous AL en urgence si vue avant 48h (soulagement rapide) ou traitement médical (antalgiques, veinotoniques, anuscopie différée).',
      answers: [
        {'text': 'Thrombose hémorroïdaire externe', 'isCorrect': true},
        {'text': 'Fissure anale', 'isCorrect': false},
        {'text': 'Abcès anal', 'isCorrect': false},
        {'text': 'Cancer anal', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un traumatisme de la main. Il ne peut plus étendre l\'index. Quelle lésion suspectez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Impossibilité d\'extension active de l\'index après traumatisme = rupture du tendon extenseur (doigt en maillet si P3, boutonnière si P2). Examen clinique : test extension contre résistance. Traitement : attelle en extension, ± chirurgie.',
      answers: [
        {'text': 'Rupture du tendon extenseur', 'isCorrect': true},
        {'text': 'Fracture de phalange', 'isCorrect': false},
        {'text': 'Entorse inter-phalangienne', 'isCorrect': false},
        {'text': 'Luxation du poignet', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une perte brutale de la vision d\'un œil, indolore, comme un "rideau noir". Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Perte brutale indolore de vision unilatérale = décollement de rétine (rideau noir) ou occlusion artérielle rétinienne. Urgence ophtalmologique absolue. Fond d\'œil en urgence. Traitement chirurgical du décollement dans les heures.',
      answers: [
        {'text': 'Décollement de rétine', 'isCorrect': true},
        {'text': 'Migraine ophtalmique', 'isCorrect': false},
        {'text': 'Conjonctivite', 'isCorrect': false},
        {'text': 'Glaucome chronique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 25 ans arrive confus après avoir pris un comprimé de drogue en boîte de nuit. Il présente mydriase, tachycardie, hypertension et agitation. Quelle drogue suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Confusion + mydriase + tachycardie + HTA + agitation = intoxication aux amphétamines/MDMA (ecstasy). Risque hyperthermie maligne, rhabdomyolyse. Traitement : benzodiazépines, refroidissement, hydratation. Éviter neuroleptiques.',
      answers: [
        {'text': 'Amphétamines/Ecstasy', 'isCorrect': true},
        {'text': 'Opiacés', 'isCorrect': false},
        {'text': 'Benzodiazépines', 'isCorrect': false},
        {'text': 'Cannabis', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Cinq patients arrivent. Quel ordre de priorité est CORRECT pour la prise en charge ?\n1) Détresse respiratoire sévère\n2) Fracture fermée de jambe\n3) Plaie suturée à contrôler\n4) Gastro-entérite sans déshydratation\n5) Certificat médical',
      difficulty: 'Moyen',
      explanation:
          'Ordre correct : 1. Détresse respiratoire (urgence vitale), 2. Fracture (urgence vraie), 3. Gastro-entérite (surveillance), 4. Contrôle de plaie (non urgent), 5. Certificat (administratif). Toujours prioriser les urgences vitales.',
      answers: [
        {'text': '1 > 2 > 4 > 3 > 5', 'isCorrect': true},
        {'text': '2 > 1 > 3 > 4 > 5', 'isCorrect': false},
        {'text': '1 > 4 > 2 > 3 > 5', 'isCorrect': false},
        {'text': '5 > 4 > 3 > 2 > 1', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur brutale du gros orteil, rouge, chaud et très douloureux au moindre contact. Il a des antécédents d\'excès alimentaires. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Monoarthrite aiguë du gros orteil (podagre) + terrain évocateur = crise de goutte. Ponction articulaire : cristaux d\'urate. Traitement : colchicine ou AINS, repos. Traitement de fond à distance (allopurinol) après 2e crise.',
      answers: [
        {'text': 'Crise de goutte', 'isCorrect': true},
        {'text': 'Arthrite septique', 'isCorrect': false},
        {'text': 'Fracture de l\'orteil', 'isCorrect': false},
        {'text': 'Ongle incarné', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient sous opiacés pour douleurs chroniques arrive inconscient, bradypnée à 6/min, myosis serré. Quel antidote administrez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Surdosage en opiacés (inconscience + bradypnée + myosis serré) : antidote = naloxone (Narcan®) IV ou IM. Effet rapide mais court (renouveler si besoin). Ventilation au masque si nécessaire. Rechercher cause du surdosage.',
      answers: [
        {'text': 'Naloxone (Narcan)', 'isCorrect': true},
        {'text': 'Flumazénil', 'isCorrect': false},
        {'text': 'N-acétylcystéine', 'isCorrect': false},
        {'text': 'Atropine', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une crise d\'asthme. Vous constatez un silence auscultatoire, des sueurs, une impossibilité de parler. Comment qualifiez-vous cette crise ?',
      difficulty: 'Moyen',
      explanation:
          'Silence auscultatoire + signes de lutte + impossibilité de parler = asthme aigu grave (AAG). Urgence vitale : nébulisations répétées (salbutamol + ipratropium), corticoïdes IV, oxygène. Si échec : intubation et ventilation mécanique.',
      answers: [
        {'text': 'Asthme aigu grave (AAG)', 'isCorrect': true},
        {'text': 'Crise d\'asthme légère', 'isCorrect': false},
        {'text': 'Bronchite aiguë', 'isCorrect': false},
        {'text': 'Pneumonie', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 55 ans arrive avec une douleur rétro-sternale d\'effort, cédant au repos en quelques minutes. ECG normal. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur thoracique d\'effort, brève, cédant au repos = angor stable. Mais ECG normal n\'élimine pas SCA ! Troponine, surveillance. Recherche ischémie (test d\'effort, coronarographie). Traitement antiagrégant, statine, dérivés nitrés.',
      answers: [
        {'text': 'Angor stable (à confirmer)', 'isCorrect': true},
        {'text': 'Infarctus du myocarde', 'isCorrect': false},
        {'text': 'Reflux gastro-œsophagien', 'isCorrect': false},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un zona ophtalmique (vésicules sur le front et paupière). Quelle complication ophtalmologique redoutez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Zona ophtalmique = risque de kératite zostérienne pouvant évoluer vers cécité. Urgence ophtalmologique : aciclovir IV + examen ophtalmo (lampe à fente). Signe de Hutchinson (atteinte pointe nez) = facteur de risque majeur.',
      answers: [
        {'text': 'Kératite zostérienne avec risque de cécité', 'isCorrect': true},
        {'text': 'Conjonctivite banale', 'isCorrect': false},
        {'text': 'Glaucome aigu', 'isCorrect': false},
        {'text': 'Décollement de rétine', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois victimes d\'un incendie arrivent. Laquelle a la priorité au triage ?\nA) Brûlures 50% surface corporelle, conscient, FR 25\nB) Brûlures 10% superficielles, marche seul\nC) Brûlures 80%, inconscient, FR 8',
      difficulty: 'Difficile',
      explanation:
          'En tri de catastrophe : patient A (brûlures graves mais sauvable, conscient) = priorité absolue (rouge). Patient B = code vert (mineur). Patient C = dépassé (noir) car pronostic très sombre, mobiliserait trop de ressources.',
      answers: [
        {'text': 'A - Brûlures 50%, sauvable', 'isCorrect': true},
        {'text': 'B - Brûlures superficielles', 'isCorrect': false},
        {'text': 'C - Brûlures 80%, inconscient', 'isCorrect': false},
        {'text': 'Tous en même temps', 'isCorrect': false},
      ],
    );

    // QUESTIONS DE TRI COMPLEXES (ajoutées pour augmenter la difficulté)

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients arrivent simultanément. Lequel priorisez-vous ?\nA) Homme 35 ans, polytraumatisé conscient, TA 90/60, FC 110\nB) Femme 60 ans, douleur thoracique depuis 10 min, TA 140/90, FC 95\nC) Homme 25 ans, plaie au bras avec hémorragie contrôlée par pansement compressif\nD) Enfant 8 ans, asthme connu, dyspnée modérée, SpO2 93%',
      difficulty: 'Difficile',
      explanation:
          'Le polytraumatisé en état de choc compensé (TA limite, tachycardie) est prioritaire car risque de décompensation rapide. La douleur thoracique est suspecte mais hémodynamique stable. L\'enfant asthmatique avec SpO2 93% est surveillance rapprochée mais pas détresse vitale immédiate. L\'hémorragie contrôlée peut attendre.',
      answers: [
        {'text': 'A - Polytraumatisé en choc compensé', 'isCorrect': true},
        {'text': 'B - Douleur thoracique', 'isCorrect': false},
        {'text': 'C - Hémorragie contrôlée', 'isCorrect': false},
        {'text': 'D - Asthme modéré', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois patients arrivent. Lequel voyez-vous en premier ?\nA) Femme 75 ans, confusion apparue il y a 2h, glycémie 0,9 g/L, TA 110/70\nB) Homme 50 ans, céphalée intense depuis 30 min, photophobie, raideur nuque\nC) Homme 40 ans, douleur abdominale depuis 12h, vomissements, fébrile 38,5°C',
      difficulty: 'Difficile',
      explanation:
          'La céphalée brutale avec syndrome méningé (photophobie, raideur) évoque une méningite ou hémorragie méningée = urgence absolue nécessitant imagerie et/ou PL immédiate. La confusion sur hypoglycémie modérée (0,9) est moins urgente. L\'abdomen aigu fébrile nécessite prise en charge rapide mais moins immédiate.',
      answers: [
        {'text': 'B - Syndrome méningé', 'isCorrect': true},
        {'text': 'A - Confusion sur hypoglycémie modérée', 'isCorrect': false},
        {'text': 'C - Abdomen aigu fébrile', 'isCorrect': false},
        {'text': 'Tous en même temps', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Aux urgences, quatre patients attendent. Lequel réévaluez-vous en priorité ?\nA) Patient avec entorse de cheville, attendant radio depuis 45 min\nB) Patient avec lombalgie aiguë, attendant depuis 30 min, commence à vomir\nC) Patient avec plaie suturée il y a 1h, saignement minime sur pansement\nD) Patient pour certificat médical, attendant depuis 2h',
      difficulty: 'Moyen',
      explanation:
          'Les vomissements chez un patient lombalgique peuvent signaler une complication (colique néphrétique, compression médullaire si déficit associé). C\'est une détérioration clinique nécessitant réévaluation. L\'entorse et la plaie sont stables, le certificat peut attendre.',
      answers: [
        {'text': 'B - Lombalgie avec vomissements', 'isCorrect': true},
        {'text': 'A - Entorse simple', 'isCorrect': false},
        {'text': 'C - Saignement minime post-suture', 'isCorrect': false},
        {'text': 'D - Certificat médical', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'En médecine de catastrophe, cinq patients arrivent. Lequel classez-vous en JAUNE (urgence relative) ?\nA) Patient conscient, fracture ouverte fémur, hémorragie active\nB) Patient conscient, fracture fermée tibia-fibula, douleur intense\nC) Patient inconscient, Glasgow 5, traumatisme crânien sévère\nD) Patient conscient qui marche, plaie superficielle bras',
      difficulty: 'Difficile',
      explanation:
          'En tri de catastrophe : Jaune = urgence différable mais nécessitant prise en charge. Fracture fermée douloureuse = jaune. Fracture ouverte hémorragique = rouge (urgent). TC sévère Glasgow 5 = rouge si sauvable ou noir si ressources limitées. Plaie superficielle marchant = vert.',
      answers: [
        {'text': 'B - Fracture fermée douloureuse', 'isCorrect': true},
        {'text': 'A - Fracture ouverte hémorragique', 'isCorrect': false},
        {'text': 'C - TC sévère Glasgow 5', 'isCorrect': false},
        {'text': 'D - Plaie superficielle', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois patients pédiatriques arrivent. Lequel évaluez-vous en premier ?\nA) Nourrisson 9 mois, bronchiolite, FR 55/min, tirage intercostal, SpO2 91%\nB) Enfant 4 ans, fièvre 39,5°C depuis 24h, bon état général\nC) Enfant 6 ans, douleur abdominale depuis 6h, défense en FID',
      difficulty: 'Moyen',
      explanation:
          'Le nourrisson en détresse respiratoire (FR élevée, tirage, désaturation modérée) nécessite prise en charge immédiate (O2, nébulisations). L\'appendicite probable (défense FID) est urgente mais chirurgie semi-urgente. La fièvre isolée avec bon état général peut attendre.',
      answers: [
        {'text': 'A - Détresse respiratoire du nourrisson', 'isCorrect': true},
        {'text': 'B - Fièvre isolée', 'isCorrect': false},
        {'text': 'C - Suspicion appendicite', 'isCorrect': false},
        {'text': 'Tous en même temps', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients arrivent après un AVP. Quel ordre de prise en charge ?\n1) Patient A : conscient, douleur thoracique, SpO2 88%\n2) Patient B : confus, TA 85/55, FC 125\n3) Patient C : conscient, fracture ouverte jambe\n4) Patient D : conscient, plaie du cuir chevelu suturée',
      difficulty: 'Moyen',
      explanation:
          'Ordre : B (choc, détérioration hémodynamique) > A (détresse respiratoire avec désaturation) > C (fracture ouverte, hémorragie potentielle) > D (plaie déjà prise en charge). Le choc prime car décompensation rapide possible.',
      answers: [
        {'text': 'B > A > C > D', 'isCorrect': true},
        {'text': 'A > B > C > D', 'isCorrect': false},
        {'text': 'C > B > A > D', 'isCorrect': false},
        {'text': 'B > C > A > D', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Lors d\'un afflux massif de victimes, comment triez-vous un patient conscient, dyspnéique avec FR 35/min, SpO2 85%, traumatisme thoracique ?',
      difficulty: 'Moyen',
      explanation:
          'Détresse respiratoire importante mais patient conscient et potentiellement sauvable avec gestes simples (O2, drainage si pneumothorax) = ROUGE (urgence absolue sauvable). Ce n\'est ni un patient dépassé (noir), ni une urgence relative (jaune).',
      answers: [
        {'text': 'Rouge (urgence absolue)', 'isCorrect': true},
        {'text': 'Jaune (urgence relative)', 'isCorrect': false},
        {'text': 'Vert (urgence mineure)', 'isCorrect': false},
        {'text': 'Noir (urgence dépassée)', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois patients arrivent. Lequel a le pronostic vital le plus engagé à court terme ?\nA) Homme 65 ans, ictère, ascite, conscience normale\nB) Femme 45 ans, céphalée + fièvre 39°C + confusion\nC) Homme 55 ans, douleur lombaire chronique',
      difficulty: 'Moyen',
      explanation:
          'Céphalées + fièvre + confusion = suspicion méningite/méningo-encéphalite = urgence vitale immédiate (sepsis neuro-méningé). L\'ictère + ascite évoque cirrhose décompensée (semi-urgence). La lombalgie chronique n\'est pas une urgence vitale.',
      answers: [
        {'text': 'B - Suspicion de méningite', 'isCorrect': true},
        {'text': 'A - Cirrhose décompensée', 'isCorrect': false},
        {'text': 'C - Lombalgie chronique', 'isCorrect': false},
        {'text': 'Tous égaux', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients cardiaques arrivent. Lequel bénéficie le plus d\'une prise en charge dans les 30 minutes ?\nA) Homme 60 ans, douleur thoracique depuis 45 min, sus-décalage ST à l\'ECG\nB) Femme 70 ans, palpitations bien tolérées, FA rapide à 140/min\nC) Homme 50 ans, HTA 190/110 asymptomatique\nD) Femme 65 ans, insuffisance cardiaque chronique stable',
      difficulty: 'Moyen',
      explanation:
          'STEMI (sus-décalage ST) < 12h = indication thrombolyse ou angioplastie primaire urgente. Délai porte-ballon crucial (< 90 min optimal). La FA rapide tolérée, l\'HTA asymptomatique et l\'IC stable sont moins urgentes.',
      answers: [
        {'text': 'A - STEMI (infarctus avec sus-ST)', 'isCorrect': true},
        {'text': 'B - FA rapide tolérée', 'isCorrect': false},
        {'text': 'C - HTA asymptomatique', 'isCorrect': false},
        {'text': 'D - IC chronique stable', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'En salle d\'attente, trois patients se dégradent simultanément. Lequel réévaluez-vous en priorité ?\nA) Patient devient agité, confus, SpO2 descend à 88%\nB) Patient vomit du sang rouge (hématémèse), hémodynamique stable\nC) Patient fait un malaise vagal, reprend conscience rapidement',
      difficulty: 'Difficile',
      explanation:
          'Confusion + désaturation = détresse respiratoire/hypoxie cérébrale = urgence immédiate (risque arrêt respiratoire). L\'hématémèse stable nécessite surveillance mais moins urgent si hémodynamique OK. Le malaise vagal résolutif est surveillance simple.',
      answers: [
        {'text': 'A - Confusion avec désaturation', 'isCorrect': true},
        {'text': 'B - Hématémèse hémodynamique stable', 'isCorrect': false},
        {'text': 'C - Malaise vagal résolutif', 'isCorrect': false},
        {'text': 'B et A en même temps', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Cinq patients arrivent. Lequel peut attendre 2 heures sans risque ?\nA) Femme 30 ans, cystite non compliquée, douleur modérée\nB) Homme 70 ans, rétention aiguë d\'urine depuis 6h\nC) Enfant 5 ans, fièvre 40°C depuis 2h\nD) Homme 45 ans, lombalgie aiguë sans déficit',
      difficulty: 'Moyen',
      explanation:
          'La cystite non compliquée sans fièvre chez femme jeune peut attendre quelques heures. La rétention urinaire nécessite sondage rapide. Fièvre 40°C chez enfant = risque convulsions. Lombalgie sans déficit = urgence relative mais douleur importante.',
      answers: [
        {'text': 'A - Cystite simple', 'isCorrect': true},
        {'text': 'B - Rétention urinaire', 'isCorrect': false},
        {'text': 'C - Fièvre 40°C enfant', 'isCorrect': false},
        {'text': 'D - Lombalgie aiguë', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois femmes enceintes arrivent. Laquelle voyez-vous en premier ?\nA) 28 SA, contractions régulières depuis 2h, col fermé\nB) 38 SA, rupture poche des eaux il y a 1h, pas de contractions\nC) 32 SA, céphalées violentes, vision floue, TA 165/105',
      difficulty: 'Moyen',
      explanation:
          'HTA + céphalées + troubles visuels = pré-éclampsie sévère à 32 SA = urgence absolue (risque éclampsie, HELLP syndrome). MAP à 28 SA col fermé = surveillance. RPM à terme sans travail = surveillance rapprochée mais moins urgent.',
      answers: [
        {'text': 'C - Pré-éclampsie sévère', 'isCorrect': true},
        {'text': 'A - MAP col fermé', 'isCorrect': false},
        {'text': 'B - RPM à terme', 'isCorrect': false},
        {'text': 'B puis C', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'En contexte d\'afflux massif, comment classez-vous un patient polytraumatisé, Glasgow 7, FR 10/min, TA 70/40, hémorragie externe contrôlée ?',
      difficulty: 'Difficile',
      explanation:
          'Glasgow 7 + FR correcte + choc hémorragique contrôlable = potentiellement sauvable avec réanimation = ROUGE (urgence absolue). Nécessite remplissage, transfusion, éventuelle chirurgie. Ce n\'est pas un patient dépassé si les hémorragies sont contrôlables.',
      answers: [
        {'text': 'Rouge (urgence absolue sauvable)', 'isCorrect': true},
        {'text': 'Noir (urgence dépassée)', 'isCorrect': false},
        {'text': 'Jaune (urgence relative)', 'isCorrect': false},
        {'text': 'Vert (urgence mineure)', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Quatre patients neurologiques arrivent. Lequel a la fenêtre thérapeutique la plus courte ?\nA) AVC ischémique débuté il y a 2h, déficit hémicorps\nB) Crise convulsive tonico-clonique durant depuis 8 minutes\nC) Céphalée brutale il y a 4h, pas de déficit\nD) Vertige rotatoire depuis 12h, nystagmus',
      difficulty: 'Difficile',
      explanation:
          'État de mal épileptique (convulsions > 5 min) = urgence immédiate nécessitant benzodiazépines IV MAINTENANT. L\'AVC < 4h30 a fenêtre thrombolyse mais quelques minutes de plus acceptables. L\'hémorragie méningée suspecte (céphalée) et le vertige sont moins urgents.',
      answers: [
        {'text': 'B - État de mal épileptique', 'isCorrect': true},
        {'text': 'A - AVC ischémique < 4h30', 'isCorrect': false},
        {'text': 'C - Suspicion hémorragie méningée', 'isCorrect': false},
        {'text': 'D - Vertige périphérique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Trois patients diabétiques arrivent confus. Lequel traitez-vous en premier ?\nA) Diabétique type 1, glycémie 0,3 g/L, sueurs, tachycardie\nB) Diabétique type 2, glycémie 6 g/L, haleine cétonique, polypnée\nC) Diabétique type 2, glycémie 2 g/L, déshydratation modérée',
      difficulty: 'Moyen',
      explanation:
          'L\'hypoglycémie sévère (0,3 g/L) peut entraîner convulsions et mort cérébrale en minutes = resucrage IMMÉDIAT. L\'acidocétose (6 g/L + cétose) et l\'hyperglycémie modérée (2 g/L) nécessitent traitement rapide mais tolérance de quelques minutes.',
      answers: [
        {'text': 'A - Hypoglycémie sévère', 'isCorrect': true},
        {'text': 'B - Acidocétose diabétique', 'isCorrect': false},
        {'text': 'C - Hyperglycémie modérée', 'isCorrect': false},
        {'text': 'B puis A', 'isCorrect': false},
      ],
    );

    // NOUVELLES QUESTIONS SUPPLÉMENTAIRES (100 questions)

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 70 ans arrive avec une rétention aiguë d\'urine et une douleur hypogastrique intense. Quelle est la première action à réaliser ?',
      difficulty: 'Facile',
      explanation:
          'La rétention aiguë d\'urine est une urgence urologique nécessitant sondage vésical évacuateur immédiat pour soulager le patient et éviter la distension vésicale. Le sondage permet aussi de quantifier le résidu et de rechercher une hématurie.',
      answers: [
        {'text': 'Sondage vésical évacuateur en urgence', 'isCorrect': true},
        {'text': 'Scanner abdominal', 'isCorrect': false},
        {'text': 'Alphabloquants per os', 'isCorrect': false},
        {'text': 'Antalgiques et attendre', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une épistaxis abondante depuis 30 minutes. Les mouchages sont inefficaces. Quelle est votre première action ?',
      difficulty: 'Moyen',
      explanation:
          'Épistaxis persistante : compression bidigitale forte 10 minutes (patient assis, tête penchée en avant). Si échec : méchage antérieur. Rechercher anticoagulants, HTA. L\'erreur est de faire pencher la tête en arrière (risque d\'inhalation).',
      answers: [
        {'text': 'Compression bidigitale forte 10 minutes, tête penchée en avant', 'isCorrect': true},
        {'text': 'Tête en arrière et glace sur le front', 'isCorrect': false},
        {'text': 'Méchage postérieur immédiat', 'isCorrect': false},
        {'text': 'Cautérisation au nitrate d\'argent d\'emblée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 45 ans présente une douleur testiculaire aiguë unilatérale depuis 2h avec nausées et vomissements. Quel diagnostic suspectez-vous en priorité ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur testiculaire aiguë brutale + nausées = torsion du cordon spermatique jusqu\'à preuve du contraire. C\'est une urgence chirurgicale (ischémie testiculaire). Échographie-doppler en urgence et avis chirurgical immédiat. Fenêtre thérapeutique de 6h pour sauver le testicule.',
      answers: [
        {'text': 'Torsion du cordon spermatique', 'isCorrect': true},
        {'text': 'Orchi-épididymite', 'isCorrect': false},
        {'text': 'Hydrocèle', 'isCorrect': false},
        {'text': 'Hernie inguinale', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive après morsure de chien sur la main il y a 6h. La plaie est inflammatoire, douloureuse et purulente. Quelle est votre prise en charge ?',
      difficulty: 'Moyen',
      explanation:
          'Morsure de main + signes d\'infection (< 24h) = urgence chirurgicale. Parage chirurgical + antibiothérapie (amoxicilline-ac. clavulanique). PAS de suture primaire des morsures (risque d\'abcès). Vérifier vaccination antitétanique. Radiographie si suspicion de corps étranger/fracture.',
      answers: [
        {'text': 'Parage chirurgical + antibiotiques, pas de suture', 'isCorrect': true},
        {'text': 'Suture simple + antibiotiques', 'isCorrect': false},
        {'text': 'Antibiotiques seuls et surveillance', 'isCorrect': false},
        {'text': 'Désinfection locale uniquement', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Une femme de 30 ans enceinte de 36 SA arrive avec perte de liquide clair depuis 2h et contractions régulières. Quelle est la priorité ?',
      difficulty: 'Facile',
      explanation:
          'Rupture de la poche des eaux à terme (36 SA) + contractions = travail en cours. Priorité : monitoring fœtal (RCF), examen obstétrical, préparation à l\'accouchement. Transfert vers maternité si urgences non adaptées. Vérifier présentation fœtale et dilatation.',
      answers: [
        {'text': 'Monitoring fœtal et examen obstétrical, transfert maternité', 'isCorrect': true},
        {'text': 'Tocolyse pour arrêter le travail', 'isCorrect': false},
        {'text': 'Antibiotiques et attendre 48h', 'isCorrect': false},
        {'text': 'Césarienne en urgence', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une luxation antérieure d\'épaule après chute. L\'épaule est bloquée en abduction-rotation externe. Quelle complication recherchez-vous avant réduction ?',
      difficulty: 'Moyen',
      explanation:
          'Avant réduction de luxation d\'épaule : rechercher complications neuro-vasculaires (pouls radial, sensibilité du moignon de l\'épaule - nerf axillaire). Radiographie pré-réduction (confirmation, éliminer fracture associée). Réduction sous analgésie/sédation. Radio post-réduction.',
      answers: [
        {'text': 'Complications neuro-vasculaires (pouls, nerf axillaire)', 'isCorrect': true},
        {'text': 'Rupture de la coiffe des rotateurs', 'isCorrect': false},
        {'text': 'Arthrose gléno-humérale', 'isCorrect': false},
        {'text': 'Tendinite du long biceps', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 3 ans arrive avec fièvre à 40°C, refus alimentaire total et hypersialorrhée (bave beaucoup). Il reste assis penché en avant. Quel diagnostic évoquez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Fièvre élevée + hypersialorrhée + position en trépied (assis penché en avant) = épiglottite aiguë (Haemophilus influenzae b). URGENCE VITALE : risque d\'obstruction complète. NE PAS examiner la gorge ! Appel anesthésiste, intubation en salle, antibiothérapie (C3G).',
      answers: [
        {'text': 'Épiglottite aiguë - Ne pas examiner la gorge !', 'isCorrect': true},
        {'text': 'Angine streptococcique', 'isCorrect': false},
        {'text': 'Laryngite aiguë', 'isCorrect': false},
        {'text': 'Abcès rétro-pharyngé', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient présente une plaie du tendon d\'Achille après coupure. Quel test clinique confirme la rupture ?',
      difficulty: 'Facile',
      explanation:
          'Test de Thompson : patient à plat ventre, compression du mollet. Si rupture du tendon d\'Achille : PAS de flexion plantaire du pied. Palpation : dépression dans le tendon. Traitement : chirurgical ou orthopédique (botte). Échographie confirme.',
      answers: [
        {'text': 'Test de Thompson (compression mollet sans flexion plantaire)', 'isCorrect': true},
        {'text': 'Test de Lachman', 'isCorrect': false},
        {'text': 'Test de Finkelstein', 'isCorrect': false},
        {'text': 'Test de Phalen', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 65 ans arrive confus avec une température à 35,2°C. Il vit seul et le chauffage est en panne depuis 3 jours. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Hypothermie modérée (32-35°C) : confusion, bradycardie, hypotension. Réchauffement externe passif (couvertures), interne actif si sévère (solutés chauds). ECG : onde J d\'Osborn. Complications : troubles du rythme, hypoglycémie, rhabdomyolyse. Bilan biologique complet.',
      answers: [
        {'text': 'Hypothermie modérée', 'isCorrect': true},
        {'text': 'AVC ischémique', 'isCorrect': false},
        {'text': 'Sepsis sévère', 'isCorrect': false},
        {'text': 'Insuffisance surrénalienne', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient sous warfarine (AVK) arrive après chute avec traumatisme crânien mineur il y a 1h. INR à 3,5. Quelle est votre conduite à tenir ?',
      difficulty: 'Moyen',
      explanation:
          'Traumatisme crânien + AVK (même mineur) = scanner cérébral SYSTÉMATIQUE (risque hématome intracrânien retardé). Surveillance 24h. Si INR > 5 ou saignement : vitamine K + CCP. Réévaluation neurologique répétée.',
      answers: [
        {'text': 'Scanner cérébral systématique + surveillance 24h', 'isCorrect': true},
        {'text': 'Surveillance clinique uniquement', 'isCorrect': false},
        {'text': 'Vitamine K et retour à domicile', 'isCorrect': false},
        {'text': 'IRM cérébrale en externe', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un œil rouge, douloureux, avec baisse d\'acuité visuelle et photophobie après coup de marteau (projection métallique). Quel examen est indispensable ?',
      difficulty: 'Moyen',
      explanation:
          'Suspicion de corps étranger intra-oculaire (CEIO) métallique après percussion : scanner orbitaire EN URGENCE. PAS d\'IRM (contre-indication absolue si métal ferreux). Examen ophtalmo au biomicroscope. Risque : endophtalmie, décollement de rétine. Chirurgie si CEIO confirmé.',
      answers: [
        {'text': 'Scanner orbitaire en urgence (PAS d\'IRM)', 'isCorrect': true},
        {'text': 'IRM orbitaire', 'isCorrect': false},
        {'text': 'Échographie oculaire seule', 'isCorrect': false},
        {'text': 'Simple lavage oculaire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient présente une plaie profonde du doigt après coupure avec couteau. Vous constatez l\'impossibilité de fléchir la dernière phalange. Quelle structure est lésée ?',
      difficulty: 'Facile',
      explanation:
          'Impossibilité de flexion de P3 (dernière phalange) = rupture du tendon fléchisseur profond. Urgence chirurgicale (suture tendineuse dans les 24h). Examen : tester FPP (flexion P3) et FPS (flexion P2). Radiographie (éliminer fracture associée).',
      answers: [
        {'text': 'Tendon fléchisseur profond des doigts', 'isCorrect': true},
        {'text': 'Tendon extenseur commun', 'isCorrect': false},
        {'text': 'Nerf médian', 'isCorrect': false},
        {'text': 'Artère radiale', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur abdominale brutale en coup de poignard, survenue après vomissements répétés. Il présente un emphysème sous-cutané cervical palpable. Quel diagnostic suspectez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Vomissements répétés + douleur brutale + emphysème sous-cutané cervical = syndrome de Boerhaave (rupture spontanée de l\'œsophage). Urgence chirurgicale absolue. Scanner thoraco-abdominal avec opacification orale. Mortalité élevée si retard diagnostique. Antibiotiques + chirurgie.',
      answers: [
        {'text': 'Syndrome de Boerhaave (perforation œsophagienne)', 'isCorrect': true},
        {'text': 'Reflux gastro-œsophagien', 'isCorrect': false},
        {'text': 'Ulcère gastrique perforé', 'isCorrect': false},
        {'text': 'Pancréatite aiguë', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 25 ans arrive avec une douleur du mollet après un match de tennis. Il décrit "un coup de fouet" à l\'arrière du mollet. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Douleur brutale en "coup de fouet" au mollet lors d\'effort = rupture du jumeau interne (gastrocnémien médial) ou du soléaire. Échographie confirme. Traitement : RICE (repos, glace, compression, élévation), AINS, rééducation progressive. Diagnostic différentiel : thrombose veineuse.',
      answers: [
        {'text': 'Rupture musculaire du triceps sural (jumeau interne)', 'isCorrect': true},
        {'text': 'Thrombose veineuse profonde', 'isCorrect': false},
        {'text': 'Rupture du tendon d\'Achille', 'isCorrect': false},
        {'text': 'Fracture de fatigue du tibia', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Une femme de 55 ans arrive avec des palpitations rapides à 180/min, régulières, depuis 2h. ECG : tachycardie à complexes fins régulière. TA 110/70. Quelle est votre première action thérapeutique ?',
      difficulty: 'Moyen',
      explanation:
          'Tachycardie supraventriculaire régulière bien tolérée : manœuvres vagales en 1ère intention (Valsalva, massage sino-carotidien). Si échec : adénosine IV en bolus rapide. Si échec ou mal tolérée : cardioversion électrique. ECG après réduction pour diagnostic étiologique.',
      answers: [
        {'text': 'Manœuvres vagales (Valsalva, massage carotidien)', 'isCorrect': true},
        {'text': 'Cardioversion électrique immédiate', 'isCorrect': false},
        {'text': 'Amiodarone IV', 'isCorrect': false},
        {'text': 'Bêtabloquants per os', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec un panaris (infection pulpe du doigt) stade 3 avec collection purulente visible. Quelle est la prise en charge ?',
      difficulty: 'Facile',
      explanation:
          'Panaris collecté (stade 3) = drainage chirurgical sous anesthésie locale ou loco-régionale. Incision, évacuation du pus, méchage. Antibiotiques (anti-staphylococcique). Antalgiques. Vérifier vaccination antitétanique. Surveillance cicatrisation et mobilité du doigt.',
      answers: [
        {'text': 'Drainage chirurgical + antibiotiques', 'isCorrect': true},
        {'text': 'Antibiotiques seuls et bains antiseptiques', 'isCorrect': false},
        {'text': 'Incision à l\'urgence sans anesthésie', 'isCorrect': false},
        {'text': 'Attendre maturation spontanée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 80 ans tombe et se plaint de douleur à la hanche. Il ne peut plus se relever ni bouger la jambe. À l\'examen : membre inférieur en rotation externe et raccourci. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Chute + impossibilité de se relever + membre en rotation externe et raccourci = fracture du col du fémur. Urgence chirurgicale (prothèse ou ostéosynthèse selon l\'âge et le déplacement). Radiographie bassin de face + hanche. Antalgie, pas de mobilisation.',
      answers: [
        {'text': 'Fracture du col du fémur', 'isCorrect': true},
        {'text': 'Luxation de hanche', 'isCorrect': false},
        {'text': 'Entorse de hanche', 'isCorrect': false},
        {'text': 'Arthrose décompensée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une brûlure chimique à l\'acide sur l\'avant-bras. Quelle est la première action à réaliser ?',
      difficulty: 'Facile',
      explanation:
          'Brûlure chimique : lavage abondant à l\'eau courante pendant 15-20 minutes IMMÉDIATEMENT (dilution et refroidissement). Retirer vêtements contaminés. PAS de neutralisation chimique (réaction exothermique aggravante). Puis pansement gras et évaluation profondeur. Antalgiques.',
      answers: [
        {'text': 'Lavage abondant eau courante 15-20 minutes', 'isCorrect': true},
        {'text': 'Neutralisation par base alcaline', 'isCorrect': false},
        {'text': 'Application immédiate de pommade', 'isCorrect': false},
        {'text': 'Pansement sec compressif', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient présente une dyspnée aiguë avec wheezing, urticaire généralisée et hypotension (TA 85/50) 10 minutes après piqûre de guêpe. Quel diagnostic posez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Urticaire + bronchospasme + hypotension après exposition allergène = choc anaphylactique. URGENCE VITALE : adrénaline IM 0,3-0,5 mg (face antérolatérale cuisse), répétable. Remplissage vasculaire, corticoïdes, antihistaminiques. Surveillance 24h. Prescription d\'adrénaline auto-injectable.',
      answers: [
        {'text': 'Choc anaphylactique - Adrénaline IM immédiate', 'isCorrect': true},
        {'text': 'Asthme aigu grave', 'isCorrect': false},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
        {'text': 'Réaction locale à la piqûre', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie par balle à l\'abdomen. Il est conscient mais pâle, TA 90/60, FC 120. Quelle est votre priorité ?',
      difficulty: 'Moyen',
      explanation:
          'Plaie abdominale pénétrante par balle + choc hémorragique = urgence chirurgicale absolue. Remplissage vasculaire en route vers bloc (damage control), scope, 2 VVP gros calibre, groupe sanguin. Appel chirurgien et anesthésiste. FAST écho au bloc. Laparotomie exploratrice.',
      answers: [
        {'text': 'Remplissage vasculaire et transfert immédiat au bloc opératoire', 'isCorrect': true},
        {'text': 'Scanner abdominal pour bilan lésionnel', 'isCorrect': false},
        {'text': 'Pansement compressif et surveillance', 'isCorrect': false},
        {'text': 'Extraction du projectile aux urgences', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 18 mois arrive après ingestion de pile bouton il y a 2h. Radiographie : pile au niveau de l\'œsophage. Quelle est votre conduite ?',
      difficulty: 'Difficile',
      explanation:
          'Pile bouton dans l\'œsophage = URGENCE ENDOSCOPIQUE (< 2h). Risque de nécrose par électrolyse et brûlure caustique en quelques heures. Extraction endoscopique en urgence. Si estomac : surveillance si pile > 15 mm. Complications : perforation, médiastinite, fistule aorto-œsophagienne.',
      answers: [
        {'text': 'Extraction endoscopique en extrême urgence (< 2h)', 'isCorrect': true},
        {'text': 'Surveillance radiologique, élimination naturelle', 'isCorrect': false},
        {'text': 'Provoquer vomissements', 'isCorrect': false},
        {'text': 'Laxatifs pour accélérer transit', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 50 ans présente une douleur abdominale aiguë en barre épigastrique irradiant dans le dos, après repas copieux arrosé. Lipase à 1500 UI/L. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Douleur épigastrique transfixiante + lipase > 3N après alcool/repas gras = pancréatite aiguë. Scanner abdominal (recherche nécrose), score de gravité (Ranson, BISAP). Traitement : réanimation hydro-électrolytique, antalgiques, mise à jeun, nutrition entérale précoce si sévère. Surveillance complications.',
      answers: [
        {'text': 'Pancréatite aiguë', 'isCorrect': true},
        {'text': 'Infarctus du myocarde inférieur', 'isCorrect': false},
        {'text': 'Cholécystite aiguë', 'isCorrect': false},
        {'text': 'Ulcère gastroduodénal perforé', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie de la main par scie circulaire avec section nette du pouce. Le segment amputé est retrouvé. Comment le conserver ?',
      difficulty: 'Moyen',
      explanation:
          'Conservation segment amputé : envelopper dans compresse stérile imbibée de sérum physiologique, mettre dans sac étanche, placer sur glace (JAMAIS contact direct glace/tissu = brûlure par le froid). Transfert urgence main. Réimplantation possible si < 6h (membre) ou < 12h (doigt) et bon état.',
      answers: [
        {'text': 'Compresse humide dans sac, sur glace (pas de contact direct)', 'isCorrect': true},
        {'text': 'Contact direct avec glace', 'isCorrect': false},
        {'text': 'Dans l\'alcool à 70°', 'isCorrect': false},
        {'text': 'À température ambiante', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 40 ans arrive confus avec des myoclonies. Il sent "l\'amande amère". Saturation à 98% mais lactates élevés. Quelle intoxication suspectez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Odeur d\'amande amère + hyperlactatémie + SpO2 normale (hypoxie cytotoxique) = intoxication aux cyanures. Antidote : hydroxocobalamine IV en urgence. Contexte : incendie (combustion plastiques), industrie. Mortalité élevée sans traitement rapide.',
      answers: [
        {'text': 'Intoxication aux cyanures', 'isCorrect': true},
        {'text': 'Intoxication au CO', 'isCorrect': false},
        {'text': 'Hypoglycémie sévère', 'isCorrect': false},
        {'text': 'Méningite bactérienne', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient présente une plaie pénétrante du thorax. Vous observez un pneumothorax sous tension avec déviation trachéale et turgescence jugulaire. Quelle est la priorité absolue ?',
      difficulty: 'Moyen',
      explanation:
          'Pneumothorax suffocant = urgence vitale immédiate. Exsufflation à l\'aiguille 2e EIC ligne médio-claviculaire en attendant drainage thoracique. Signes : détresse respiratoire, tympanisme, abolition MV, déviation trachéale controlatérale, turgescence jugulaire, collapsus.',
      answers: [
        {'text': 'Exsufflation à l\'aiguille puis drainage thoracique', 'isCorrect': true},
        {'text': 'Radiographie thoracique d\'abord', 'isCorrect': false},
        {'text': 'Intubation orotrachéale seule', 'isCorrect': false},
        {'text': 'Remplissage vasculaire massif', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec fièvre à 39°C, frissons et douleur lombaire unilatérale gauche. Bandelette urinaire : leucocytes +++, nitrites +. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Fièvre + douleur lombaire + leucocyturie/nitrites = pyélonéphrite aiguë. ECBU avec antibiogramme. Échographie rénale (éliminer obstacle). Antibiothérapie probabiliste (C3G ou fluoroquinolone). Hospitalisation si signes de gravité, homme, grossesse, obstacle.',
      answers: [
        {'text': 'Pyélonéphrite aiguë', 'isCorrect': true},
        {'text': 'Cystite simple', 'isCorrect': false},
        {'text': 'Colique néphrétique', 'isCorrect': false},
        {'text': 'Appendicite', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 60 ans arrive avec une dyspnée aiguë, toux avec expectoration rosée mousseuse, crépitants bilatéraux, SpO2 85%. TA 180/110. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Dyspnée aiguë + expectoration rosée mousseuse + crépitants bilatéraux + HTA = œdème aigu pulmonaire (OAP) cardiogénique. Traitement : position demi-assise, O2, diurétiques IV (furosémide), dérivés nitrés. Rechercher étiologie (cardiopathie). Ventilation non invasive si besoin.',
      answers: [
        {'text': 'Œdème aigu pulmonaire (OAP)', 'isCorrect': true},
        {'text': 'Pneumonie bilatérale', 'isCorrect': false},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
        {'text': 'Exacerbation de BPCO', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur oculaire intense, œil rouge avec mydriase aréactive et œdème cornéen. La palpation révèle un globe dur. Quel diagnostic posez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur oculaire + œil rouge + mydriase aréactive + globe dur = glaucome aigu par fermeture de l\'angle. URGENCE ophtalmologique (risque de cécité). Traitement : acétazolamide IV, mannitol, collyres myotiques + bêtabloquants. Iridotomie laser après normalisation PIO.',
      answers: [
        {'text': 'Glaucome aigu par fermeture de l\'angle', 'isCorrect': true},
        {'text': 'Uvéite antérieure aiguë', 'isCorrect': false},
        {'text': 'Kératite herpétique', 'isCorrect': false},
        {'text': 'Hémorragie du vitré', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 75 ans sous anticoagulants arrive avec céphalées brutales et vomissements. Scanner : hématome extra-dural. INR à 5. Quelle est votre prise en charge immédiate ?',
      difficulty: 'Difficile',
      explanation:
          'Hématome intracrânien + AVK surdosé = urgence neurochirurgicale. Antagonisation immédiate : vitamine K 10 mg IV LENTE + CCP (concentrés de complexe prothrombinique). Contrôle INR. Avis neurochirurgical. Monitoring neurologique, PIC si besoin. Chirurgie selon localisation/volume.',
      answers: [
        {'text': 'Vitamine K IV + CCP (concentrés prothrombine) + neurochirurgie', 'isCorrect': true},
        {'text': 'Vitamine K seule et surveillance', 'isCorrect': false},
        {'text': 'Transfusion de plasma frais congelé', 'isCorrect': false},
        {'text': 'Arrêt AVK et contrôle INR dans 24h', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 6 ans arrive avec douleur abdominale péri-ombilicale, fièvre à 38,5°C et vomissements depuis 24h. La douleur s\'est déplacée en fosse iliaque droite. Quel diagnostic suspectez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Migration douleur péri-ombilicale → FID + fièvre + vomissements = appendicite aiguë (séquence classique de Murphy). Défense FID (signe de Bloomberg). Échographie abdominale. Chirurgie (appendicectomie). NFS : hyperleucocytose. Perforation si retard > 48h.',
      answers: [
        {'text': 'Appendicite aiguë', 'isCorrect': true},
        {'text': 'Gastro-entérite', 'isCorrect': false},
        {'text': 'Adénolymphite mésentérique', 'isCorrect': false},
        {'text': 'Constipation', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient présente une plaie du genou après chute. À l\'examen, vous observez un écoulement de liquide clair par la plaie. Quelle complication suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Écoulement de liquide clair par plaie du genou = suspicion d\'arthrotomie (ouverture articulaire avec fuite de liquide synovial). URGENCE chirurgicale : risque d\'arthrite septique. Parage chirurgical, lavage articulaire, antibioprophylaxie. Radiographie (corps étranger, fracture).',
      answers: [
        {'text': 'Arthrotomie (plaie articulaire)', 'isCorrect': true},
        {'text': 'Bursite pré-rotulienne', 'isCorrect': false},
        {'text': 'Plaie tendineuse simple', 'isCorrect': false},
        {'text': 'Lymphorrhée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 28 ans arrive avec douleur thoracique latéralisée brutale et dyspnée après effort de toux. Il est grand et mince. SpO2 92%, tympanisme unilatéral. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Patient longiligne + douleur thoracique brutale + dyspnée + tympanisme = pneumothorax spontané primaire (rupture de bulle d\'emphysème). Radiographie thorax confirme. Traitement selon importance : surveillance, exsufflation, drainage. Récidive fréquente.',
      answers: [
        {'text': 'Pneumothorax spontané', 'isCorrect': true},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
        {'text': 'Infarctus du myocarde', 'isCorrect': false},
        {'text': 'Péricardite aiguë', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec brûlures du visage, suies dans les narines, voix rauque et toux après incendie en milieu clos. Quelle complication redoutez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Brûlures faciales + suies + voix rauque en contexte d\'incendie clos = inhalation de fumées avec risque d\'œdème laryngé. INTUBATION PRÉCOCE avant œdème (critères : dysphonie, stridor, dyspnée). Fibroscopie bronchique. Recherche intoxication CO et cyanures. Ventilation mécanique.',
      answers: [
        {'text': 'Œdème laryngé avec obstruction des voies aériennes', 'isCorrect': true},
        {'text': 'Pneumonie simple', 'isCorrect': false},
        {'text': 'Sinusite aiguë', 'isCorrect': false},
        {'text': 'Rhinite thermique isolée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec colique néphrétique gauche hyperalgique résistant aux antalgiques usuels. Créatinine à 250 µmol/L (N < 110), fièvre à 38,8°C. Quelle est votre conduite ?',
      difficulty: 'Difficile',
      explanation:
          'Colique néphrétique + fièvre + insuffisance rénale aiguë = URGENCE urologique (pyélonéphrite obstructive ou anurie). Échographie urgente. Drainage en urgence (sonde JJ ou néphrostomie percutanée) + antibiothérapie. Risque de choc septique et nécrose rénale.',
      answers: [
        {'text': 'Drainage urinaire urgent (sonde JJ) + antibiotiques', 'isCorrect': true},
        {'text': 'AINS et surveillance externe', 'isCorrect': false},
        {'text': 'Lithotritie extracorporelle en urgence', 'isCorrect': false},
        {'text': 'Morphine et attendre élimination spontanée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 35 ans arrive avec une plaie du poignet par bris de vitre. Vous constatez l\'impossibilité d\'extension du pouce et une anesthésie du dos de la main entre pouce et index. Quelle structure est lésée ?',
      difficulty: 'Moyen',
      explanation:
          'Impossibilité extension pouce + anesthésie 1ère commissure dorsale = section du nerf radial (branche sensitive superficielle). Également : perte extension poignet si lésion haute. Urgence chirurgicale pour suture nerveuse. Exploration et réparation tendineuse éventuelle. Pronostic récupération variable.',
      answers: [
        {'text': 'Nerf radial', 'isCorrect': true},
        {'text': 'Nerf médian', 'isCorrect': false},
        {'text': 'Nerf ulnaire', 'isCorrect': false},
        {'text': 'Artère radiale seule', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 4 ans arrive avec douleur du coude après chute sur la main tendue. Le coude est déformé et l\'enfant refuse toute mobilisation. Quel diagnostic suspectez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Chute sur main tendue chez enfant + déformation coude = fracture supracondylienne de l\'humérus (la plus fréquente chez l\'enfant). URGENCE : vérifier pouls radial (artère humérale) et sensibilité (nerf radial, médian, ulnaire). Réduction orthopédique ou chirurgicale. Syndrome de Volkmann si ischémie.',
      answers: [
        {'text': 'Fracture supracondylienne de l\'humérus', 'isCorrect': true},
        {'text': 'Luxation du coude', 'isCorrect': false},
        {'text': 'Fracture de la clavicule', 'isCorrect': false},
        {'text': 'Entorse du coude', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 70 ans arrive avec un tableau de confusion aiguë. Il est sous diurétiques. Kaliémie à 2,5 mmol/L. ECG : ondes U, sous-décalage ST. Quelle est votre prise en charge ?',
      difficulty: 'Moyen',
      explanation:
          'Hypokaliémie sévère < 2,8 avec anomalies ECG = urgence (risque troubles du rythme graves). Supplémentation potassique IV LENTE en milieu surveillé (max 20 mmol/h). Scope cardiaque continu. Corriger cause (diurétiques, vomissements). Magnésémie souvent basse aussi.',
      answers: [
        {'text': 'Supplémentation potassique IV lente sous scope', 'isCorrect': true},
        {'text': 'Potassium per os et retour à domicile', 'isCorrect': false},
        {'text': 'Bolus rapide de KCl IV', 'isCorrect': false},
        {'text': 'Surveillance simple sans traitement', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive après AVP avec fracture ouverte du tibia. La jambe est froide, pâle, sans pouls pédieux. Quelle complication suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Fracture + membre froid/pâle/sans pouls = ischémie aiguë de membre par lésion artérielle (section, thrombose, compression). URGENCE chirurgicale vasculaire absolue (ischémie chaude < 6h). Réduction de fracture, artériographie ou angio-scanner, revascularisation. Risque amputation.',
      answers: [
        {'text': 'Ischémie aiguë de membre par lésion artérielle', 'isCorrect': true},
        {'text': 'Syndrome de loge', 'isCorrect': false},
        {'text': 'Œdème post-traumatique', 'isCorrect': false},
        {'text': 'Lésion nerveuse isolée', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Une femme de 25 ans arrive avec métrorragies abondantes, douleurs pelviennes et syncope. Test de grossesse positif, TA 85/55, FC 115. Échographie : hémopéritoine, pas d\'embryon intra-utérin. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Grossesse extra-utérine (GEU) rompue avec hémopéritoine et choc hémorragique. URGENCE chirurgicale absolue (cœlioscopie ou laparotomie). Remplissage vasculaire, groupe sanguin, hCG. Salpingectomie ou traitement conservateur selon lésions. Mortalité si retard.',
      answers: [
        {'text': 'Grossesse extra-utérine rompue', 'isCorrect': true},
        {'text': 'Fausse couche spontanée', 'isCorrect': false},
        {'text': 'Kyste ovarien rompu', 'isCorrect': false},
        {'text': 'Menstruations abondantes', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec céphalées violentes, fièvre à 39,5°C, raideur de nuque et photophobie. Vous suspectez une méningite. Quelle est votre conduite immédiate ?',
      difficulty: 'Moyen',
      explanation:
          'Suspicion méningite bactérienne : antibiothérapie IMMÉDIATE sans attendre la PL si signes de gravité (C3G type ceftriaxone). PL après (sauf contre-indication). Scanner si signes de focalisation. Isolement respiratoire si méningocoque. Corticoïdes (dexaméthasone) avant ou avec antibiotiques.',
      answers: [
        {'text': 'Antibiothérapie immédiate puis ponction lombaire', 'isCorrect': true},
        {'text': 'Ponction lombaire puis antibiotiques', 'isCorrect': false},
        {'text': 'Scanner cérébral puis PL puis antibiotiques', 'isCorrect': false},
        {'text': 'Attendre résultats biologiques', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 55 ans arrive avec douleur abdominale diffuse et arrêt des matières et des gaz depuis 48h. Abdomen distendu, tympanique, absence de bruits hydroaériques. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Arrêt matières et gaz + distension + tympanisme + silence auscultatoire = occlusion intestinale. Radiographie ASP debout : niveaux hydro-aériques. Scanner abdominal : recherche cause (bride, tumeur, volvulus). Sonde nasogastrique, remplissage, avis chirurgical. Chirurgie selon étiologie.',
      answers: [
        {'text': 'Occlusion intestinale', 'isCorrect': true},
        {'text': 'Constipation fonctionnelle', 'isCorrect': false},
        {'text': 'Gastro-entérite', 'isCorrect': false},
        {'text': 'Syndrome de l\'intestin irritable', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie de l\'avant-bras par morsure humaine lors d\'une bagarre (coup de poing dans la bouche). Quelle est votre prise en charge spécifique ?',
      difficulty: 'Moyen',
      explanation:
          'Morsure humaine (fight bite) = très septique (Eikenella corrodens + anaérobies). JAMAIS suturer. Parage chirurgical + antibiothérapie (amoxicilline-ac. clavulanique ou C2G). Radiographie (fracture métacarpien, dent). Risque d\'arthrite si articulation touchée. Tétanos.',
      answers: [
        {'text': 'Parage chirurgical + antibiotiques, pas de suture', 'isCorrect': true},
        {'text': 'Suture primaire + antibioprophylaxie', 'isCorrect': false},
        {'text': 'Désinfection et cicatrisation dirigée seule', 'isCorrect': false},
        {'text': 'Aucun traitement spécifique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 3 ans arrive avec détresse respiratoire, tirage, stridor et hypersialorrhée. Il refuse de s\'allonger et reste assis. Température à 40°C. Quelle est votre attitude ?',
      difficulty: 'Difficile',
      explanation:
          'Épiglottite aiguë suspectée : NE PAS allonger l\'enfant, NE PAS examiner la gorge (risque obstruction complète). Appel anesthésiste/ORL en urgence. Intubation en salle d\'opération sous AG. Antibiothérapie C3G après sécurisation des voies aériennes. Urgence vitale absolue.',
      answers: [
        {'text': 'Ne pas allonger, ne pas examiner gorge, appel anesthésiste', 'isCorrect': true},
        {'text': 'Examen oropharyngé systématique', 'isCorrect': false},
        {'text': 'Corticoïdes et surveillance externe', 'isCorrect': false},
        {'text': 'Adrénaline nébulisée seule', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 50 ans arrive avec une douleur scrotale aiguë et un testicule surélevé horizontal ("en battant de cloche"). Réflexe crémastérien aboli. Quel diagnostic posez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur scrotale aiguë + testicule horizontal + abolition réflexe crémastérien = torsion du cordon spermatique. URGENCE chirurgicale (détorsion < 6h). Échographie-doppler confirme mais ne doit pas retarder chirurgie si clinique évocatrice. Orchidopexie bilatérale.',
      answers: [
        {'text': 'Torsion du cordon spermatique', 'isCorrect': true},
        {'text': 'Orchi-épididymite', 'isCorrect': false},
        {'text': 'Varicocèle aiguë', 'isCorrect': false},
        {'text': 'Hydrocèle', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 65 ans sous AINS pour arthrose arrive avec méléna (selles noires) depuis 2 jours et pâleur. TA 95/60, FC 105. Hb à 7 g/dL. Quel diagnostic suspectez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Méléna + anémie + instabilité hémodynamique + AINS = hémorragie digestive haute (ulcère gastroduodénal probable). Remplissage vasculaire, transfusion, IPP IV forte dose. Fibroscopie œso-gastro-duodénale en urgence (hémostase endoscopique). Arrêt AINS.',
      answers: [
        {'text': 'Hémorragie digestive haute (ulcère)', 'isCorrect': true},
        {'text': 'Hémorroïdes', 'isCorrect': false},
        {'text': 'Cancer colique', 'isCorrect': false},
        {'text': 'Diverticulose colique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une douleur brutale du mollet droit, œdème important et impossibilité de marcher. Le mollet est très tendu et douloureux à la palpation. Les pouls distaux sont présents. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur brutale + mollet tendu et dur + pouls présents après effort = syndrome de loge aigu (rhabdomyolyse, œdème musculaire dans loges aponévrotiques inextensibles). Mesure des pressions > 30 mmHg. Urgence chirurgicale : aponévrotomie de décharge. Risque ischémie et nécrose musculaire.',
      answers: [
        {'text': 'Syndrome de loge aigu', 'isCorrect': true},
        {'text': 'Thrombose veineuse profonde', 'isCorrect': false},
        {'text': 'Rupture musculaire simple', 'isCorrect': false},
        {'text': 'Crampe musculaire', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 30 ans arrive agité, avec hallucinations visuelles (voit des insectes), tremblements et sueurs profuses. Il est éthylique chronique et n\'a pas bu depuis 48h. Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Sevrage alcoolique brutal + hallucinations visuelles + tremblements + sueurs = delirium tremens. Urgence vitale (risque convulsions, collapsus). Traitement : benzodiazépines IV (diazépam), vitaminothérapie B1/B6, réhydratation, surveillance scopée. Thiamine AVANT glucose (Gayet-Wernicke).',
      answers: [
        {'text': 'Delirium tremens', 'isCorrect': true},
        {'text': 'Intoxication éthylique aiguë', 'isCorrect': false},
        {'text': 'Schizophrénie aiguë', 'isCorrect': false},
        {'text': 'Encéphalopathie de Gayet-Wernicke', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 40 ans arrive avec une plaie profonde de la cuisse par couteau. La plaie saigne en jet pulsatile rouge vif. Quelle est votre première action ?',
      difficulty: 'Facile',
      explanation:
          'Hémorragie artérielle en jet = compression directe forte immédiate de la plaie (gants stériles ou compresse). Si échec : compression proximale sur trajet artériel. Garrot en dernier recours si hémorragie incontrôlable. Remplissage vasculaire, scope, avis chirurgical/vasculaire urgent.',
      answers: [
        {'text': 'Compression directe forte de la plaie', 'isCorrect': true},
        {'text': 'Garrot immédiat sur cuisse', 'isCorrect': false},
        {'text': 'Clampage artériel à la pince', 'isCorrect': false},
        {'text': 'Pansement compressif et attente', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 75 ans arrive avec des douleurs abdominales diffuses et pulsations abdominales. TA 90/50, FC 110, pâleur. Échographie : masse abdominale pulsatile de 8 cm. Quel diagnostic suspectez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur abdominale + masse pulsatile + choc = rupture d\'anévrisme de l\'aorte abdominale. URGENCE chirurgicale vasculaire absolue. Remplissage contrôlé (éviter HTA qui aggrave saignement), transfusion, bloc opératoire immédiat. Mortalité très élevée (> 50%).',
      answers: [
        {'text': 'Rupture d\'anévrisme de l\'aorte abdominale', 'isCorrect': true},
        {'text': 'Occlusion intestinale', 'isCorrect': false},
        {'text': 'Péritonite', 'isCorrect': false},
        {'text': 'Pancréatite aiguë', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une brûlure circonférentielle du thorax (2e et 3e degré). Il présente une dyspnée avec tirage et ampliation thoracique limitée. Quelle complication suspectez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Brûlure circonférentielle thoracique profonde → escarre rigide limitant expansion thoracique = syndrome restrictif avec détresse respiratoire. Traitement : incisions de décharge (escarrotomies) en urgence pour permettre ventilation. Analgésie, intubation si besoin.',
      answers: [
        {'text': 'Syndrome restrictif nécessitant escarrotomies', 'isCorrect': true},
        {'text': 'Pneumonie d\'inhalation', 'isCorrect': false},
        {'text': 'Embolie pulmonaire', 'isCorrect': false},
        {'text': 'Œdème pulmonaire lésionnel', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec diplopie binoculaire, mydriase bilatérale aréactive, sécheresse buccale et constipation sévère après consommation de conserves maison. Quel diagnostic évoquez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Paralysie oculomotrice + mydriase + troubles digestifs après conserves = botulisme (toxine Clostridium botulinum). Urgence : antitoxine botulique précoce, surveillance respiratoire (paralysie descendante). Intubation si atteinte diaphragmatique. Déclaration obligatoire.',
      answers: [
        {'text': 'Botulisme', 'isCorrect': true},
        {'text': 'Myasthénie grave', 'isCorrect': false},
        {'text': 'Syndrome de Guillain-Barré', 'isCorrect': false},
        {'text': 'Intoxication aux organophosphorés', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 60 ans arrive avec douleur rétro-sternale constrictive depuis 45 min, résistante à la trinitrine. ECG : sus-décalage ST en antérieur étendu. Quel est le traitement urgent ?',
      difficulty: 'Moyen',
      explanation:
          'Douleur > 20 min + sus-ST = STEMI (infarctus avec sus-décalage ST). Urgence : reperfusion coronaire (angioplastie primaire < 90 min ou thrombolyse < 12h si angioplastie impossible). Aspirine, clopidogrel, héparine, morphine. Transfert USIC/salle de cathétérisme.',
      answers: [
        {'text': 'Angioplastie coronaire primaire en urgence < 90 min', 'isCorrect': true},
        {'text': 'Thrombolyse systématique', 'isCorrect': false},
        {'text': 'Hospitalisation et troponine de contrôle', 'isCorrect': false},
        {'text': 'Bêtabloquants IV et surveillance', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec une plaie profonde de l\'abdomen par arme blanche. Vous observez une extériorisation de l\'intestin grêle. Quelle est votre conduite immédiate ?',
      difficulty: 'Moyen',
      explanation:
          'Éviscération traumatique : NE JAMAIS réintégrer les viscères (risque infection). Recouvrir avec champ stérile imbibé de sérum physiologique tiède. Scope, 2 VVP, remplissage, antibioprophylaxie. Appel chirurgien en urgence. Bloc opératoire pour exploration et réintégration chirurgicale.',
      answers: [
        {'text': 'Recouvrir avec champ stérile humide, bloc opératoire', 'isCorrect': true},
        {'text': 'Réintégrer immédiatement les viscères', 'isCorrect': false},
        {'text': 'Suturer la plaie en urgence', 'isCorrect': false},
        {'text': 'Scanner abdominal d\'abord', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un enfant de 8 mois arrive avec pleurs inconsolables, vomissements et émission de "gelée de groseille" (sang et mucus) par l\'anus. À la palpation : masse abdominale en "boudin". Quel diagnostic évoquez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Triade : pleurs paroxystiques + vomissements + rectorragies "gelée de groseille" + masse en boudin = invagination intestinale aiguë (IIA). Urgence pédiatrique. Échographie confirme (cocarde). Réduction par lavement aux hydrosolubles ou chirurgie si échec/complications.',
      answers: [
        {'text': 'Invagination intestinale aiguë', 'isCorrect': true},
        {'text': 'Appendicite aiguë', 'isCorrect': false},
        {'text': 'Gastro-entérite aiguë', 'isCorrect': false},
        {'text': 'Volvulus du grêle', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 55 ans arrive avec douleur de la fosse lombaire droite, hématurie macroscopique et fièvre à 39°C. Échographie : dilatation pyélocalicielle et calcul urétéral de 8 mm. Quelle est votre conduite ?',
      difficulty: 'Moyen',
      explanation:
          'Fièvre + obstacle lithiasique + dilatation = pyélonéphrite obstructive. URGENCE urologique : drainage en urgence (sonde JJ ou néphrostomie) + antibiothérapie (C3G ou FQ). Risque de choc septique et abcès rénal. Traitement du calcul secondairement.',
      answers: [
        {'text': 'Drainage urinaire urgent + antibiotiques', 'isCorrect': true},
        {'text': 'Lithotritie extracorporelle immédiate', 'isCorrect': false},
        {'text': 'AINS et hydratation seuls', 'isCorrect': false},
        {'text': 'Antibiotiques seuls et surveillance', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec douleur aiguë de l\'œil droit, baisse brutale d\'acuité visuelle et phosphènes (éclairs lumineux). Fond d\'œil : voile grisâtre masquant la rétine. Quel diagnostic posez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Phosphènes + baisse brutale acuité + voile grisâtre au FO = décollement de rétine. URGENCE ophtalmologique. Pas d\'effort, position déclive du décollement. Laser ou chirurgie (vitrectomie, indentation). Risque de cécité définitive si retard. Myopie = facteur de risque.',
      answers: [
        {'text': 'Décollement de rétine', 'isCorrect': true},
        {'text': 'Décollement du vitré postérieur', 'isCorrect': false},
        {'text': 'Névrite optique rétro-bulbaire', 'isCorrect': false},
        {'text': 'Cataracte aiguë', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient sous neuroleptiques arrive avec fièvre à 41°C, rigidité musculaire extrême, sueurs profuses et confusion. CPK à 15000 UI/L. Quel diagnostic posez-vous ?',
      difficulty: 'Difficile',
      explanation:
          'Neuroleptiques + hyperthermie majeure + rigidité + rhabdomyolyse (CPK élevées) = syndrome malin des neuroleptiques. URGENCE vitale : arrêt neuroleptiques, refroidissement externe, dantrolène IV, réanimation hydro-électrolytique. Mortalité 10-20%. Complications : IRA, CIVD.',
      answers: [
        {'text': 'Syndrome malin des neuroleptiques', 'isCorrect': true},
        {'text': 'Méningite bactérienne', 'isCorrect': false},
        {'text': 'Crise comitiale prolongée', 'isCorrect': false},
        {'text': 'Hyperthermie maligne peranesthésique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 70 ans arrive avec une fibrillation auriculaire rapide à 150/min apparue il y a 6h. Il est asymptomatique, TA 135/85. Quelle est votre conduite ?',
      difficulty: 'Moyen',
      explanation:
          'FA récente (< 48h) bien tolérée : cardioversion électrique ou pharmacologique possible SANS anticoagulation préalable (risque thromboembolique faible). Si FA > 48h ou inconnue : anticoagulation 3 semaines avant cardioversion OU ETO (échographie trans-œsophagienne) pour éliminer thrombus.',
      answers: [
        {'text': 'Cardioversion possible sans anticoagulation (FA < 48h)', 'isCorrect': true},
        {'text': 'Anticoagulation 3 semaines obligatoire d\'abord', 'isCorrect': false},
        {'text': 'Digoxine per os et surveillance', 'isCorrect': false},
        {'text': 'Aucun traitement si asymptomatique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 35 ans arrive après traumatisme de la main avec plaie du pouce. Vous constatez l\'impossibilité d\'opposer le pouce (toucher l\'auriculaire). Quelle structure nerveuse est lésée ?',
      difficulty: 'Moyen',
      explanation:
          'Perte d\'opposition du pouce = atteinte du nerf médian (innerve le court abducteur et opposant du pouce). Également : anesthésie face palmaire des 3 premiers doigts et moitié radiale du 4e. Urgence chirurgicale pour suture nerveuse. Test : signe de la bouteille (impossibilité de tenir bouteille).',
      answers: [
        {'text': 'Nerf médian', 'isCorrect': true},
        {'text': 'Nerf ulnaire', 'isCorrect': false},
        {'text': 'Nerf radial', 'isCorrect': false},
        {'text': 'Tendon long fléchisseur du pouce', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec syndrome confusionnel aigu, fièvre à 38,2°C et rigidité de nuque. Scanner cérébral normal. Vous décidez de faire une ponction lombaire. Le LCR est trouble. Quelle est votre conduite immédiate ?',
      difficulty: 'Moyen',
      explanation:
          'LCR trouble = méningite bactérienne probable. Antibiothérapie IMMÉDIATE sans attendre résultats (C3G type ceftriaxone 2g). Dexaméthasone avant ou avec 1ère dose antibiotiques. Prélèvements bactériologiques (LCR, hémocultures). Isolement respiratoire. Déclaration si méningocoque.',
      answers: [
        {'text': 'Antibiothérapie immédiate (C3G) sans attendre résultats', 'isCorrect': true},
        {'text': 'Attendre résultats du LCR avant traitement', 'isCorrect': false},
        {'text': 'Aciclovir IV d\'emblée', 'isCorrect': false},
        {'text': 'Corticoïdes seuls', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 20 ans arrive après chute en skateboard. Il se plaint de douleur à l\'épaule et présente un "signe de l\'épaulette" (saillie acromiale). Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Signe de l\'épaulette (vide sous-acromial, saillie acromion) après traumatisme = luxation antéro-interne de l\'épaule (la plus fréquente). Vérifier pouls radial et sensibilité (nerf axillaire). Radio pré-réduction. Réduction sous analgésie/sédation (manœuvre de Stimson, Kocher). Radio post-réduction.',
      answers: [
        {'text': 'Luxation antérieure de l\'épaule', 'isCorrect': true},
        {'text': 'Fracture de la clavicule', 'isCorrect': false},
        {'text': 'Rupture de la coiffe des rotateurs', 'isCorrect': false},
        {'text': 'Fracture du col huméral', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient arrive avec vertiges rotatoires intenses, nausées et vomissements. Nystagmus horizontal. Pas de signe neurologique. Audiométrie normale. Quel diagnostic évoquez-vous ?',
      difficulty: 'Facile',
      explanation:
          'Vertiges rotatoires + nystagmus horizontal + audition normale + pas de signes neuro = vertige positionnel paroxystique bénin (VPPB) ou névrite vestibulaire. Manœuvre de Dix-Hallpike diagnostique. Traitement : manœuvre libératoire (Epley), antivertigineux symptomatiques. Évolue favorablement.',
      answers: [
        {'text': 'Vertige positionnel paroxystique bénin (VPPB)', 'isCorrect': true},
        {'text': 'AVC du tronc cérébral', 'isCorrect': false},
        {'text': 'Maladie de Ménière', 'isCorrect': false},
        {'text': 'Neurinome de l\'acoustique', 'isCorrect': false},
      ],
    );

    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L3',
      questionText:
          'Un patient de 45 ans arrive avec œdème aigu du visage, lèvres gonflées, dyspnée laryngée avec stridor après prise d\'un IEC pour HTA. Quel diagnostic posez-vous ?',
      difficulty: 'Moyen',
      explanation:
          'Œdème facial + lèvres + dyspnée laryngée sous IEC = œdème de Quincke (angio-œdème) par accumulation de bradykinine. URGENCE : intubation si détresse respiratoire (avant œdème complet !), adrénaline IM, corticoïdes IV, antihistaminiques. Arrêt définitif IEC. Surveillance 24h.',
      answers: [
        {'text': 'Œdème de Quincke (angio-œdème) aux IEC', 'isCorrect': true},
        {'text': 'Réaction allergique à un aliment', 'isCorrect': false},
        {'text': 'Cellulite cervico-faciale', 'isCorrect': false},
        {'text': 'Syndrome cave supérieur', 'isCorrect': false},
      ],
    );
  }

  static Future<void> _addQuestion(
    Database db, {
    required int categoryId,
    required String yearLevel,
    required String questionText,
    required String difficulty,
    required String explanation,
    required List<Map<String, dynamic>> answers,
  }) async {
    // Insérer la question
    final questionId = await db.insert('questions', {
      'category_id': categoryId,
      'year_level': yearLevel,
      'question_text': questionText,
      'difficulty': difficulty,
      'explanation': explanation,
    });

    // Insérer les réponses
    for (var answer in answers) {
      await db.insert('answers', {
        'question_id': questionId,
        'answer_text': answer['text'],
        'is_correct': answer['isCorrect'] ? 1 : 0,
      });
    }
  }
}

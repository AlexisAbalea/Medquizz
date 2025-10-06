import 'package:medquizz_pass/data/datasources/database_helper.dart';

class SeedData {
  static Future<void> initialize() async {
    final db = DatabaseHelper.instance;

    // Vérifier si les données existent déjà
    final categories = await db.queryAll('categories');
    if (categories.isNotEmpty) {
      return; // Données déjà initialisées
    }

    // Insérer les catégories
    await _insertCategories(db);

    // Insérer les questions et réponses
    await _insertQuestionsAndAnswers(db);
  }

  static Future<void> _insertCategories(DatabaseHelper db) async {
    final categories = [
      // L1
      {
        'name': 'Anatomie',
        'year_level': 'L1',
        'icon': 'anatomy',
        'color': '#E91E63',
        'description': 'Structure du corps humain'
      },
      {
        'name': 'Physiologie',
        'year_level': 'L1',
        'icon': 'physiology',
        'color': '#2196F3',
        'description': 'Fonctionnement des organes'
      },
      {
        'name': 'Biochimie',
        'year_level': 'L1',
        'icon': 'biochemistry',
        'color': '#4CAF50',
        'description': 'Réactions chimiques dans le corps'
      },
      {
        'name': 'Biologie Cellulaire',
        'year_level': 'L1',
        'icon': 'cell',
        'color': '#FF9800',
        'description': 'Étude des cellules'
      },
      // L2
      {
        'name': 'Pharmacologie',
        'year_level': 'L2',
        'icon': 'pharmacy',
        'color': '#9C27B0',
        'description': 'Médicaments et leurs effets'
      },
      {
        'name': 'Pathologie',
        'year_level': 'L2',
        'icon': 'pathology',
        'color': '#F44336',
        'description': 'Étude des maladies'
      },
      {
        'name': 'Immunologie',
        'year_level': 'L2',
        'icon': 'immune',
        'color': '#00BCD4',
        'description': 'Système immunitaire'
      },
      {
        'name': 'Microbiologie',
        'year_level': 'L2',
        'icon': 'bacteria',
        'color': '#8BC34A',
        'description': 'Étude des micro-organismes'
      },
      // L3
      {
        'name': 'Sémiologie',
        'year_level': 'L3',
        'icon': 'stethoscope',
        'color': '#3F51B5',
        'description': 'Signes et symptômes'
      },
      {
        'name': 'Cardiologie',
        'year_level': 'L3',
        'icon': 'heart',
        'color': '#E91E63',
        'description': 'Maladies cardiaques'
      },
      {
        'name': 'Neurologie',
        'year_level': 'L3',
        'icon': 'brain',
        'color': '#673AB7',
        'description': 'Système nerveux'
      },
      {
        'name': 'Radiologie',
        'year_level': 'L3',
        'icon': 'xray',
        'color': '#607D8B',
        'description': 'Imagerie médicale'
      },
      // Catégories "Questions aléatoires" pour chaque niveau
      {
        'name': 'Questions aléatoires',
        'year_level': 'L1',
        'icon': 'shuffle',
        'color': '#FF5722',
        'description': 'Questions mélangées de toutes les matières'
      },
      {
        'name': 'Questions aléatoires',
        'year_level': 'L2',
        'icon': 'shuffle',
        'color': '#FF5722',
        'description': 'Questions mélangées de toutes les matières'
      },
      {
        'name': 'Questions aléatoires',
        'year_level': 'L3',
        'icon': 'shuffle',
        'color': '#FF5722',
        'description': 'Questions mélangées de toutes les matières'
      },
    ];

    for (var category in categories) {
      await db.insert('categories', category);
    }
  }

  static Future<void> _insertQuestionsAndAnswers(DatabaseHelper db) async {
    // Questions L1 - Anatomie (categoryId: 1)
    await _insertQuestion(
      db,
      categoryId: 1,
      yearLevel: 'L1',
      questionText:
          'Combien de vertèbres compose la colonne vertébrale humaine ?',
      difficulty: 'Facile',
      explanation:
          'La colonne vertébrale est composée de 33 vertèbres : 7 cervicales, 12 thoraciques, 5 lombaires, 5 sacrées (fusionnées) et 4 coccygiennes (fusionnées).',
      answers: [
        {'text': '24 vertèbres', 'isCorrect': false},
        {'text': '26 vertèbres', 'isCorrect': false},
        {'text': '33 vertèbres', 'isCorrect': true},
        {'text': '40 vertèbres', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 1,
      yearLevel: 'L1',
      questionText: 'Quel est le plus grand os du corps humain ?',
      difficulty: 'Facile',
      explanation:
          'Le fémur est le plus grand et le plus solide os du corps humain. Il s\'étend de la hanche au genou.',
      answers: [
        {'text': 'L\'humérus', 'isCorrect': false},
        {'text': 'Le tibia', 'isCorrect': false},
        {'text': 'Le fémur', 'isCorrect': true},
        {'text': 'Le radius', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 1,
      yearLevel: 'L1',
      questionText: 'Combien de chambres possède le cœur humain ?',
      difficulty: 'Facile',
      explanation:
          'Le cœur humain possède 4 chambres : 2 oreillettes (ou atriums) et 2 ventricules.',
      answers: [
        {'text': '2 chambres', 'isCorrect': false},
        {'text': '3 chambres', 'isCorrect': false},
        {'text': '4 chambres', 'isCorrect': true},
        {'text': '5 chambres', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 1,
      yearLevel: 'L1',
      questionText:
          'Quel muscle est responsable de la respiration principale ?',
      difficulty: 'Moyen',
      explanation:
          'Le diaphragme est le muscle respiratoire principal. Sa contraction permet l\'inspiration en augmentant le volume de la cage thoracique.',
      answers: [
        {'text': 'Le diaphragme', 'isCorrect': true},
        {'text': 'Les intercostaux', 'isCorrect': false},
        {'text': 'Les abdominaux', 'isCorrect': false},
        {'text': 'Le sternocléidomastoïdien', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 1,
      yearLevel: 'L1',
      questionText: 'Où se situe la glande thyroïde ?',
      difficulty: 'Moyen',
      explanation:
          'La thyroïde est située à la base du cou, devant la trachée, juste en dessous du larynx.',
      answers: [
        {'text': 'Dans le cerveau', 'isCorrect': false},
        {'text': 'Dans le cou', 'isCorrect': true},
        {'text': 'Dans le thorax', 'isCorrect': false},
        {'text': 'Dans l\'abdomen', 'isCorrect': false},
      ],
    );

    // Questions L1 - Physiologie (categoryId: 2)
    await _insertQuestion(
      db,
      categoryId: 2,
      yearLevel: 'L1',
      questionText: 'Quelle est la fonction principale des globules rouges ?',
      difficulty: 'Facile',
      explanation:
          'Les globules rouges (érythrocytes) transportent l\'oxygène des poumons vers les tissus et le CO2 des tissus vers les poumons grâce à l\'hémoglobine.',
      answers: [
        {'text': 'Combattre les infections', 'isCorrect': false},
        {'text': 'Transporter l\'oxygène', 'isCorrect': true},
        {'text': 'Coaguler le sang', 'isCorrect': false},
        {'text': 'Produire des hormones', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 2,
      yearLevel: 'L1',
      questionText:
          'Quel est le pH normal du sang artériel chez un adulte sain ?',
      difficulty: 'Moyen',
      explanation:
          'Le pH sanguin normal est légèrement basique, compris entre 7,35 et 7,45. La valeur moyenne est de 7,4.',
      answers: [
        {'text': '6,8 - 7,0', 'isCorrect': false},
        {'text': '7,0 - 7,2', 'isCorrect': false},
        {'text': '7,35 - 7,45', 'isCorrect': true},
        {'text': '7,6 - 7,8', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 2,
      yearLevel: 'L1',
      questionText:
          'Quelle hormone régule principalement le taux de glucose sanguin ?',
      difficulty: 'Moyen',
      explanation:
          'L\'insuline, sécrétée par le pancréas, permet de diminuer la glycémie en favorisant l\'entrée du glucose dans les cellules.',
      answers: [
        {'text': 'Le cortisol', 'isCorrect': false},
        {'text': 'L\'adrénaline', 'isCorrect': false},
        {'text': 'L\'insuline', 'isCorrect': true},
        {'text': 'La thyroxine', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 2,
      yearLevel: 'L1',
      questionText: 'Quelle est la fréquence cardiaque normale au repos ?',
      difficulty: 'Facile',
      explanation:
          'Au repos, la fréquence cardiaque normale d\'un adulte se situe entre 60 et 100 battements par minute.',
      answers: [
        {'text': '40-60 bpm', 'isCorrect': false},
        {'text': '60-100 bpm', 'isCorrect': true},
        {'text': '100-120 bpm', 'isCorrect': false},
        {'text': '120-140 bpm', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 2,
      yearLevel: 'L1',
      questionText:
          'Quel organe produit la bile nécessaire à la digestion des graisses ?',
      difficulty: 'Facile',
      explanation:
          'Le foie produit la bile qui est stockée dans la vésicule biliaire. La bile émulsionne les graisses pour faciliter leur digestion.',
      answers: [
        {'text': 'Le pancréas', 'isCorrect': false},
        {'text': 'Le foie', 'isCorrect': true},
        {'text': 'L\'estomac', 'isCorrect': false},
        {'text': 'L\'intestin grêle', 'isCorrect': false},
      ],
    );

    // Questions L1 - Biochimie (categoryId: 3)
    await _insertQuestion(
      db,
      categoryId: 3,
      yearLevel: 'L1',
      questionText: 'Combien d\'acides aminés sont essentiels chez l\'adulte ?',
      difficulty: 'Moyen',
      explanation:
          'Il existe 9 acides aminés essentiels que le corps ne peut pas synthétiser et qui doivent être apportés par l\'alimentation.',
      answers: [
        {'text': '6 acides aminés', 'isCorrect': false},
        {'text': '9 acides aminés', 'isCorrect': true},
        {'text': '12 acides aminés', 'isCorrect': false},
        {'text': '20 acides aminés', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 3,
      yearLevel: 'L1',
      questionText: 'Quel est le principal glucide de réserve chez l\'homme ?',
      difficulty: 'Facile',
      explanation:
          'Le glycogène est le glucide de réserve stocké principalement dans le foie et les muscles.',
      answers: [
        {'text': 'Le glucose', 'isCorrect': false},
        {'text': 'Le glycogène', 'isCorrect': true},
        {'text': 'L\'amidon', 'isCorrect': false},
        {'text': 'Le fructose', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 3,
      yearLevel: 'L1',
      questionText: 'Où se déroule la glycolyse dans la cellule ?',
      difficulty: 'Moyen',
      explanation:
          'La glycolyse se déroule dans le cytoplasme et permet de transformer le glucose en pyruvate.',
      answers: [
        {'text': 'Dans les mitochondries', 'isCorrect': false},
        {'text': 'Dans le cytoplasme', 'isCorrect': true},
        {'text': 'Dans le noyau', 'isCorrect': false},
        {'text': 'Dans le réticulum endoplasmique', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 3,
      yearLevel: 'L1',
      questionText:
          'Quel est le nombre de molécules d\'ATP produites par la glycolyse aérobie complète d\'une molécule de glucose ?',
      difficulty: 'Difficile',
      explanation:
          'La dégradation complète d\'une molécule de glucose produit environ 30-32 molécules d\'ATP (bilan net).',
      answers: [
        {'text': '2 ATP', 'isCorrect': false},
        {'text': '8 ATP', 'isCorrect': false},
        {'text': '18 ATP', 'isCorrect': false},
        {'text': '30-32 ATP', 'isCorrect': true},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 3,
      yearLevel: 'L1',
      questionText: 'Quelle vitamine est nécessaire à la coagulation sanguine ?',
      difficulty: 'Moyen',
      explanation:
          'La vitamine K est essentielle à la synthèse des facteurs de coagulation II, VII, IX et X.',
      answers: [
        {'text': 'Vitamine A', 'isCorrect': false},
        {'text': 'Vitamine C', 'isCorrect': false},
        {'text': 'Vitamine D', 'isCorrect': false},
        {'text': 'Vitamine K', 'isCorrect': true},
      ],
    );

    // Questions L2 - Pharmacologie (categoryId: 5)
    await _insertQuestion(
      db,
      categoryId: 5,
      yearLevel: 'L2',
      questionText: 'Qu\'est-ce que la pharmacocinétique ?',
      difficulty: 'Moyen',
      explanation:
          'La pharmacocinétique étudie le devenir du médicament dans l\'organisme : absorption, distribution, métabolisme et élimination (ADME).',
      answers: [
        {
          'text': 'L\'effet du médicament sur l\'organisme',
          'isCorrect': false
        },
        {
          'text': 'Le devenir du médicament dans l\'organisme',
          'isCorrect': true
        },
        {'text': 'Les interactions médicamenteuses', 'isCorrect': false},
        {'text': 'La toxicité des médicaments', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 5,
      yearLevel: 'L2',
      questionText:
          'Quel organe est principalement responsable du métabolisme des médicaments ?',
      difficulty: 'Facile',
      explanation:
          'Le foie est l\'organe principal de métabolisation des médicaments grâce aux enzymes du cytochrome P450.',
      answers: [
        {'text': 'Les reins', 'isCorrect': false},
        {'text': 'Le foie', 'isCorrect': true},
        {'text': 'Les poumons', 'isCorrect': false},
        {'text': 'L\'intestin', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 5,
      yearLevel: 'L2',
      questionText: 'Que signifie DL50 en pharmacologie ?',
      difficulty: 'Moyen',
      explanation:
          'La DL50 (Dose Létale 50) est la dose qui provoque la mort de 50% d\'une population animale testée.',
      answers: [
        {'text': 'Dose minimale efficace', 'isCorrect': false},
        {'text': 'Dose létale pour 50% de la population', 'isCorrect': true},
        {'text': 'Dose maximale tolérée', 'isCorrect': false},
        {'text': 'Dose thérapeutique standard', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 5,
      yearLevel: 'L2',
      questionText:
          'Quel est le mécanisme d\'action des anti-inflammatoires non stéroïdiens (AINS) ?',
      difficulty: 'Moyen',
      explanation:
          'Les AINS inhibent les cyclo-oxygénases (COX-1 et COX-2), réduisant ainsi la production de prostaglandines inflammatoires.',
      answers: [
        {'text': 'Inhibition de la COX', 'isCorrect': true},
        {'text': 'Inhibition de la LOX', 'isCorrect': false},
        {'text': 'Activation des récepteurs aux glucocorticoïdes', 'isCorrect': false},
        {'text': 'Blocage des récepteurs H1', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 5,
      yearLevel: 'L2',
      questionText: 'Quel est l\'antidote de l\'intoxication par les opiacés ?',
      difficulty: 'Moyen',
      explanation:
          'La naloxone est un antagoniste des récepteurs opioïdes utilisé en urgence pour traiter les surdoses d\'opiacés.',
      answers: [
        {'text': 'L\'atropine', 'isCorrect': false},
        {'text': 'La naloxone', 'isCorrect': true},
        {'text': 'Le flumazénil', 'isCorrect': false},
        {'text': 'La N-acétylcystéine', 'isCorrect': false},
      ],
    );

    // Questions L2 - Pathologie (categoryId: 6)
    await _insertQuestion(
      db,
      categoryId: 6,
      yearLevel: 'L2',
      questionText: 'Qu\'est-ce qu\'une hyperplasie ?',
      difficulty: 'Moyen',
      explanation:
          'L\'hyperplasie est l\'augmentation du nombre de cellules d\'un tissu, conduisant à une augmentation de son volume.',
      answers: [
        {'text': 'Augmentation de la taille des cellules', 'isCorrect': false},
        {'text': 'Augmentation du nombre de cellules', 'isCorrect': true},
        {'text': 'Transformation cellulaire anormale', 'isCorrect': false},
        {'text': 'Mort cellulaire programmée', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 6,
      yearLevel: 'L2',
      questionText: 'Quelle est la différence entre nécrose et apoptose ?',
      difficulty: 'Moyen',
      explanation:
          'La nécrose est une mort cellulaire pathologique avec inflammation, tandis que l\'apoptose est une mort cellulaire programmée et contrôlée sans inflammation.',
      answers: [
        {
          'text': 'La nécrose est programmée, l\'apoptose est accidentelle',
          'isCorrect': false
        },
        {
          'text': 'La nécrose cause de l\'inflammation, pas l\'apoptose',
          'isCorrect': true
        },
        {
          'text': 'Il n\'y a aucune différence',
          'isCorrect': false
        },
        {
          'text': 'L\'apoptose concerne uniquement les cellules cancéreuses',
          'isCorrect': false
        },
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 6,
      yearLevel: 'L2',
      questionText: 'Quel type de tumeur est toujours bénigne ?',
      difficulty: 'Moyen',
      explanation:
          'Un lipome est une tumeur bénigne du tissu adipeux. Il ne métastase pas et a une croissance lente.',
      answers: [
        {'text': 'Le carcinome', 'isCorrect': false},
        {'text': 'Le lipome', 'isCorrect': true},
        {'text': 'Le sarcome', 'isCorrect': false},
        {'text': 'Le mélanome', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 6,
      yearLevel: 'L2',
      questionText:
          'Quels sont les 5 signes cardinaux de l\'inflammation selon Celse ?',
      difficulty: 'Difficile',
      explanation:
          'Les 5 signes de l\'inflammation sont : rougeur (rubor), chaleur (calor), douleur (dolor), tuméfaction (tumor) et perte de fonction (functio laesa).',
      answers: [
        {
          'text': 'Rougeur, chaleur, douleur, gonflement, perte de fonction',
          'isCorrect': true
        },
        {
          'text': 'Fièvre, frissons, douleur, fatigue, nausée',
          'isCorrect': false
        },
        {
          'text': 'Rougeur, démangeaison, douleur, chaleur, sécheresse',
          'isCorrect': false
        },
        {
          'text': 'Gonflement, raideur, fatigue, fièvre, douleur',
          'isCorrect': false
        },
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 6,
      yearLevel: 'L2',
      questionText: 'Qu\'est-ce qu\'une métastase ?',
      difficulty: 'Facile',
      explanation:
          'Une métastase est une tumeur secondaire formée par la migration de cellules cancéreuses depuis la tumeur primaire vers un autre organe.',
      answers: [
        {'text': 'Une tumeur bénigne', 'isCorrect': false},
        {
          'text': 'Une tumeur secondaire à distance',
          'isCorrect': true
        },
        {'text': 'Une inflammation chronique', 'isCorrect': false},
        {'text': 'Une malformation congénitale', 'isCorrect': false},
      ],
    );

    // Questions L3 - Sémiologie (categoryId: 9)
    await _insertQuestion(
      db,
      categoryId: 9,
      yearLevel: 'L3',
      questionText: 'Qu\'est-ce qu\'une dyspnée ?',
      difficulty: 'Facile',
      explanation:
          'La dyspnée est une difficulté respiratoire ou une sensation d\'essoufflement.',
      answers: [
        {'text': 'Difficulté à avaler', 'isCorrect': false},
        {'text': 'Difficulté à respirer', 'isCorrect': true},
        {'text': 'Difficulté à parler', 'isCorrect': false},
        {'text': 'Difficulté à marcher', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 9,
      yearLevel: 'L3',
      questionText: 'Que signifie le terme "hémoptysie" ?',
      difficulty: 'Moyen',
      explanation:
          'L\'hémoptysie est le rejet de sang provenant des voies respiratoires lors de la toux.',
      answers: [
        {'text': 'Vomissement de sang', 'isCorrect': false},
        {'text': 'Crachement de sang', 'isCorrect': true},
        {'text': 'Sang dans les urines', 'isCorrect': false},
        {'text': 'Sang dans les selles', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 9,
      yearLevel: 'L3',
      questionText: 'Qu\'est-ce qu\'un œdème ?',
      difficulty: 'Facile',
      explanation:
          'Un œdème est une accumulation anormale de liquide dans les tissus interstitiels.',
      answers: [
        {'text': 'Une inflammation', 'isCorrect': false},
        {'text': 'Une accumulation de liquide', 'isCorrect': true},
        {'text': 'Une tumeur', 'isCorrect': false},
        {'text': 'Une infection', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 9,
      yearLevel: 'L3',
      questionText: 'Quelle est la définition d\'une syncope ?',
      difficulty: 'Moyen',
      explanation:
          'Une syncope est une perte de connaissance brutale, brève et complète avec récupération spontanée, liée à une hypoperfusion cérébrale transitoire.',
      answers: [
        {'text': 'Perte de mémoire temporaire', 'isCorrect': false},
        {
          'text': 'Perte de connaissance brève et réversible',
          'isCorrect': true
        },
        {'text': 'Vertige intense', 'isCorrect': false},
        {'text': 'Trouble de l\'équilibre', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 9,
      yearLevel: 'L3',
      questionText: 'Que désigne le terme "ictère" ?',
      difficulty: 'Facile',
      explanation:
          'L\'ictère (ou jaunisse) est une coloration jaune de la peau et des muqueuses due à l\'accumulation de bilirubine.',
      answers: [
        {'text': 'Coloration bleue de la peau', 'isCorrect': false},
        {'text': 'Coloration jaune de la peau', 'isCorrect': true},
        {'text': 'Coloration rouge de la peau', 'isCorrect': false},
        {'text': 'Pâleur de la peau', 'isCorrect': false},
      ],
    );

    // Questions L3 - Cardiologie (categoryId: 10)
    await _insertQuestion(
      db,
      categoryId: 10,
      yearLevel: 'L3',
      questionText:
          'Quel est le principal facteur de risque modifiable de l\'infarctus du myocarde ?',
      difficulty: 'Facile',
      explanation:
          'Le tabagisme est l\'un des principaux facteurs de risque cardiovasculaire modifiables, avec l\'hypertension et le diabète.',
      answers: [
        {'text': 'L\'âge', 'isCorrect': false},
        {'text': 'Le sexe masculin', 'isCorrect': false},
        {'text': 'Le tabagisme', 'isCorrect': true},
        {'text': 'Les antécédents familiaux', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 10,
      yearLevel: 'L3',
      questionText:
          'Quel examen est l\'examen de référence pour diagnostiquer un infarctus du myocarde ?',
      difficulty: 'Moyen',
      explanation:
          'L\'électrocardiogramme (ECG) associé au dosage des troponines est l\'examen de référence pour le diagnostic d\'infarctus.',
      answers: [
        {'text': 'Radiographie thoracique', 'isCorrect': false},
        {'text': 'Électrocardiogramme (ECG)', 'isCorrect': true},
        {'text': 'Échographie cardiaque', 'isCorrect': false},
        {'text': 'IRM cardiaque', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 10,
      yearLevel: 'L3',
      questionText: 'Qu\'est-ce que la fibrillation auriculaire ?',
      difficulty: 'Moyen',
      explanation:
          'La fibrillation auriculaire est un trouble du rythme cardiaque caractérisé par une activité électrique anarchique des oreillettes.',
      answers: [
        {'text': 'Un arrêt cardiaque', 'isCorrect': false},
        {
          'text': 'Un trouble du rythme auriculaire',
          'isCorrect': true
        },
        {'text': 'Une maladie des valves cardiaques', 'isCorrect': false},
        {'text': 'Une inflammation du péricarde', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 10,
      yearLevel: 'L3',
      questionText:
          'Quelle valve cardiaque est la plus fréquemment touchée par le rétrécissement valvulaire ?',
      difficulty: 'Moyen',
      explanation:
          'Le rétrécissement aortique est la valvulopathie la plus fréquente dans les pays occidentaux, souvent liée au vieillissement.',
      answers: [
        {'text': 'Valve mitrale', 'isCorrect': false},
        {'text': 'Valve aortique', 'isCorrect': true},
        {'text': 'Valve tricuspide', 'isCorrect': false},
        {'text': 'Valve pulmonaire', 'isCorrect': false},
      ],
    );

    await _insertQuestion(
      db,
      categoryId: 10,
      yearLevel: 'L3',
      questionText:
          'Quelle est la pression artérielle normale chez un adulte au repos ?',
      difficulty: 'Facile',
      explanation:
          'Une pression artérielle normale est inférieure à 120/80 mmHg. Au-delà de 140/90 mmHg, on parle d\'hypertension.',
      answers: [
        {'text': '90/60 mmHg', 'isCorrect': false},
        {'text': '120/80 mmHg', 'isCorrect': true},
        {'text': '140/90 mmHg', 'isCorrect': false},
        {'text': '160/100 mmHg', 'isCorrect': false},
      ],
    );

    // Seed data initialized successfully
  }

  static Future<void> _insertQuestion(
    DatabaseHelper db, {
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

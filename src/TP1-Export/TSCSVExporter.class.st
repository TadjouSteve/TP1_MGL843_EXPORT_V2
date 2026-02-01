Class {
	#name : 'TSCSVExporter',
	#superclass : 'Object',
	#category : 'TP1-Export',
	#package : 'TP1-Export'
}

{ #category : 'as yet unclassified' }
TSCSVExporter >> exportClassesToCSV [
    | stream writer classes model |
    
    "1. Récupérer le modèle TypeScript chargé dans Moose"
    model := MooseModel root allModels 
        detect: [ :m | m name includesSubstring: '.json' ] 
        ifNone: [ MooseModel root first ].

    "2. Sélectionner toutes les classes du projet"
    classes := model allModelClasses.

    "3. Préparer le fichier (il sera dans le dossier de ton image Pharo)"
    stream := 'export_donnees_tp1.csv' asFileReference writeStream.
    
    "4. Configurer NeoCSV"
    writer := NeoCSVWriter on: stream.
    writer separator: $;. "Utilise le point-virgule pour Excel"
    
    "En-tête du CSV"
    writer nextPut: #( 'Nom_Classe' 'Nb_Methodes' 'Nb_Attributs' 'Lignes_de_Code' ).

    "Données"
    classes do: [ :each |
        writer nextPut: { 
            each name. 
            each numberOfMethods. 
            each numberOfAttributes. 
            each numberOfLinesOfCode 
        } ].

    stream close.
    
    self inform: 'Exportation terminée dans le fichier export_donnees_tp1.csv'
]

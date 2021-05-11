// weapon_weights project common_explosives.go
package main

import (
	"fmt"
	"os"
	"strings"

	"text/template"

	"github.com/gocarina/gocsv"
)

const (
	itemExplosives string = "Explosives"
	itemGrenade    string = "Grenade"
	itemCommon     string = "Common"
	itemMedicine   string = "Medicine"
	itemBackpack   string = "Backpack"
	itemBinoculars string = "Binoculars"
	itemMagazine   string = "CommonMag"
	itemAce        string = "ACEItem"
	itemAceGrenade string = "ACEGrenade"
)

type Item struct {
	Category string `csv:"type"`
	Name     string `csv:"name"`
}

func processCommonItems(filepath *string, writeFiles bool) error {
	itemsList, err := parseItemsCsv(filepath)
	if err != nil {
		return fmt.Errorf("failed to parse CSV: %w", err)
	}

	commonItems := map[string][]string{
		itemCommon:     []string{},
		itemMedicine:   []string{},
		itemBackpack:   []string{},
		itemBinoculars: []string{},
	}

	explosiveItems := map[string][]string{
		itemExplosives: []string{},
		itemGrenade:    []string{},
	}

	ACEItems := map[string][]string{
		itemAce:        []string{},
		itemAceGrenade: []string{},
	}

	for _, item := range itemsList {
		switch item.Category {
		case itemExplosives:
			explosiveItems[item.Category] = append(explosiveItems[item.Category], item.Name)
		case itemGrenade:
			explosiveItems[item.Category] = append(explosiveItems[item.Category], item.Name)
		case itemCommon:
			commonItems[item.Category] = append(commonItems[item.Category], item.Name)
		case itemMedicine:
			commonItems[item.Category] = append(commonItems[item.Category], item.Name)
		case itemBackpack:
			commonItems[item.Category] = append(commonItems[item.Category], item.Name)
		case itemBinoculars:
			commonItems[item.Category] = append(commonItems[item.Category], item.Name)
		case itemMagazine:
			commonItems[item.Category] = append(commonItems[item.Category], item.Name)
		case itemAce:
			ACEItems[item.Category] = append(ACEItems[item.Category], item.Name)
		case itemAceGrenade:
			ACEItems[item.Category] = append(ACEItems[item.Category], item.Name)
		}
	}

	iTpl, err := template.New("common_explosives.tpl").Funcs(template.FuncMap{
		"ToLower": func(s string) string { return strings.ToLower(s) },
	}).ParseFiles("common_explosives.tpl")
	if err != nil {
		return fmt.Errorf("failed to parse common items template: %w", err)
	}

	err = writeTemplate("universal", iTpl, explosiveItems, writeFiles, "explosives")
	if err != nil {
		return fmt.Errorf("failed to execute explosive items template: %w", err)
	}

	err = writeTemplate("", iTpl, commonItems, writeFiles, "common_items")
	if err != nil {
		return fmt.Errorf("failed to execute common items template: %w", err)
	}

	err = writeTemplate("", iTpl, ACEItems, writeFiles, "ace_items")
	if err != nil {
		return fmt.Errorf("failed to execute ACE items template: %w", err)
	}

	return nil
}

func parseItemsCsv(filepath *string) ([]*Item, error) {
	csvFile, err := os.OpenFile(*filepath, os.O_RDONLY, os.ModePerm)
	if err != nil {
		return nil, fmt.Errorf("failed to open file: %w", err)
	}

	items := []*Item{}
	if err := gocsv.UnmarshalFile(csvFile, &items); err != nil {
		return nil, fmt.Errorf("failed to parse file: %w", err)
	}

	return items, nil
}

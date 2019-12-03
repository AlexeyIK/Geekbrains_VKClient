//
//  GroupsList.swift
//  iOS_UI_practice1
//
//  Created by Alex on 03.12.2019.
//  Copyright © 2019 Alexey Kuznetsov. All rights reserved.
//

import Foundation
import UIKit

struct GroupsData {
    
    // Тестовые группы для отображения в таблице
    static var testList : [Group] =
    [
        Group(name: "Музыка на каждый день", type: GroupType.Music, membersCount: 10521, isAMember: true, image: UIImage(named: "group_ava_music")!),
        Group(name: "Мемасики", type: GroupType.Humor, membersCount: 152438, isAMember: true, image: UIImage(named: "group_ava_memes")!),
        Group(name: "Все о фотографии", type: GroupType.Photography, membersCount: 2598, isAMember: true, image: UIImage(named: "group_ava_photo")!),
        Group(name: "Фильмотека", type: GroupType.Movies, membersCount: 21103, isAMember: true, image: UIImage(named: "group_ava_movies")!),
        Group(name: "Гифки на любой случай", type: GroupType.Humor, membersCount: 43328, isAMember: false, image: UIImage(named: "group_ava_gifs")!),
        Group(name: "Все об играх", type: GroupType.Games, membersCount: 52409, isAMember: false, image: UIImage(named: "group_ava_games")!)
    ]
    
    static var myGroups : [Group] = []
    static var otherGroups : [Group] = []
    
    static func updateList() {
        myGroups = []
        otherGroups = []
        
        for group in GroupsData.testList {
            if group.isMeInGroup {
                GroupsData.myGroups.append(group)
            }
            else {
                GroupsData.otherGroups.append(group)
            }
        }
    }
}

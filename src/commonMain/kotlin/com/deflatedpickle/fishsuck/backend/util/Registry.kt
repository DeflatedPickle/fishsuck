/* Copyright (c) 2021 DeflatedPickle under the MIT license */

@file:Suppress("MemberVisibilityCanBePrivate", "unused")

package com.deflatedpickle.fishsuck.backend.util

open class Registry<K, V> {
    private val items = mutableMapOf<K, V>()

    operator fun set(key: K, value: V) {
        this.items[key] = value
    }
    operator fun get(key: K): V? = this.items[key]

    fun has(key: K): Boolean = this.items.containsKey(key)
    fun getAll(): Map<K, V> = this.items.toMap()

    fun getOrRegister(key: K, value: V): V? {
        if (!this.has(key)) {
            this[key] = value
        }
        return this[key]
    }

    fun getOrRegister(key: K, value: () -> V): V? = getOrRegister(key, value())
}

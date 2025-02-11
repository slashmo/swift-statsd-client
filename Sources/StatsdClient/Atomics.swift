//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftStatsdClient open source project
//
// Copyright (c) 2019-2023 the SwiftStatsdClient project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftStatsdClient project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Foundation
#if canImport(Atomics)
import Atomics
#else
import NIOConcurrencyHelpers
#endif

internal class AtomicCounter {
    #if canImport(Atomics)
    private let managed: ManagedAtomic<Int64>
    #else
    private let nio: NIOAtomic<Int64>
    #endif

    init(_ value: Int64) {
        #if canImport(Atomics)
        self.managed = ManagedAtomic(value)
        #else
        self.nio = NIOAtomic.makeAtomic(value: value)
        #endif
    }

    func load() -> Int64 {
        #if canImport(Atomics)
        return self.managed.load(ordering: .sequentiallyConsistent)
        #else
        return self.nio.load()
        #endif
    }

    func compareExchange(expected: Int64, desired: Int64) -> Bool {
        #if canImport(Atomics)
        return self.managed.compareExchange(
            expected: expected,
            desired: desired,
            ordering: .sequentiallyConsistent
        ).exchanged
        #else
        return self.nio.compareAndExchange(expected: expected, desired: desired)
        #endif
    }

    func store(_ value: Int64) {
        #if canImport(Atomics)
        self.managed.store(value, ordering: .sequentiallyConsistent)
        #else
        self.nio.store(value)
        #endif
    }
}

internal class AtomicBoolean {
    #if canImport(Atomics)
    private let managed: ManagedAtomic<Bool>
    #else
    private let nio: NIOAtomic<Bool>
    #endif

    init(_ value: Bool) {
        #if canImport(Atomics)
        self.managed = ManagedAtomic(value)
        #else
        self.nio = NIOAtomic.makeAtomic(value: value)
        #endif
    }

    func load() -> Bool {
        #if canImport(Atomics)
        return self.managed.load(ordering: .sequentiallyConsistent)
        #else
        return self.nio.load()
        #endif
    }

    func compareExchange(expected: Bool, desired: Bool) -> Bool {
        #if canImport(Atomics)
        return self.managed.compareExchange(
            expected: expected,
            desired: desired,
            ordering: .sequentiallyConsistent
        ).exchanged
        #else
        return self.nio.compareAndExchange(expected: expected, desired: desired)
        #endif
    }

    func store(_ value: Bool) {
        #if canImport(Atomics)
        self.managed.store(value, ordering: .sequentiallyConsistent)
        #else
        self.nio.store(value)
        #endif
    }
}

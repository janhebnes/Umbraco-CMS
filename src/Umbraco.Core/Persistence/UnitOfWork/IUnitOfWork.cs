﻿using System;
using Umbraco.Core.Models.EntityBase;
using Umbraco.Core.Persistence.Repositories;

namespace Umbraco.Core.Persistence.UnitOfWork
{
    /// <summary>
    /// Represents a persistence unit of work.
    /// </summary>
    public interface IUnitOfWork : IDisposable
    {
        // fixme - we should get rid of all references to database here, or merge IUnitOfWork with IDatabaseUnitOfWork
        // fixme - do we have a scope.Begin()? or is it even automatic? and then do we need Begin() at all?

        /// <summary>
        /// Begins the unit of work.
        /// </summary>
        /// <remarks>When a unit of work begins, a local transaction scope is created at database level.
        /// This is useful eg when reading entities before creating, updating or deleting, and the read
        /// needs to be part of the transaction. Flushing or completing the unit of work automatically
        /// begins the transaction (so no need to call Begin if not necessary).</remarks>
        void Begin();

        /// <summary>
        /// Flushes the unit of work.
        /// </summary>
        /// <remarks>
        /// <para>When a unit of work is flushed, all queued operations are executed. This is useful eg
        /// when a row needs to be created in the database, so that its auto-generated ID can be retrieved.
        /// Note that it does *not* complete the unit of work, however. Completing the unit of work
        /// automatically flushes the queue (so no need to call Flush if not necessary).</para>
        /// </remarks>
        void Flush();

        /// <summary>
        /// Completes the unit of work.
        /// </summary>
        /// <remarks>When a unit of work is completed, a local transaction scope is created at database level,
        /// all queued operations are executed, and the scope is commited. If the unit of work is not completed
        /// before it is disposed, all queued operations are cleared and the scope is rolled back (and also
        /// higher level transactions if any).
        /// Whether this actually commits or rolls back the transaction depends on whether the transaction scope
        /// is part of a higher level transactions. The  database transaction is committed or rolled back only
        /// when the upper level scope is disposed.
        /// If any operation is added to the unit of work after it has been completed, then its completion
        /// status is resetted. So in a way it could be possible to always complete and never flush, but flush
        /// is preferred when appropriate to indicate that you understand what you are doing.
        /// Every units of work should be completed, unless a rollback is required. That is, even if the unit of
        /// work contains only read operations, that do not need to be "commited", the unit of work should be
        /// properly completed, else it may force an unexpected rollback of a higher-level transaction.
        /// </remarks>
        void Complete();

        /// <summary>
        /// Creates a repository.
        /// </summary>
        /// <typeparam name="TRepository">The type of the repository.</typeparam>
        /// <returns>The created repository for the unit of work.</returns>
        TRepository CreateRepository<TRepository>()
            where TRepository : IRepository;
    }
}

Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1A351585
	for <lists+kvmarm@lfdr.de>; Thu,  1 Apr 2021 16:08:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 587DF4B673;
	Thu,  1 Apr 2021 10:08:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnQcG1+G1-bP; Thu,  1 Apr 2021 10:08:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AD7A4B6C2;
	Thu,  1 Apr 2021 10:08:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C84DF4B67B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Apr 2021 09:55:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E+qEGDgpeyNO for <kvmarm@lists.cs.columbia.edu>;
 Thu,  1 Apr 2021 09:55:31 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C9544B696
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Apr 2021 09:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617285331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dm8QNSV3W7Q2lqn5B08UjvbkkAU4JlmGE1UT9JWvOc=;
 b=Fn+iwXNq64ro+brECTqm7G5uPehIMvUUmEypP4G+CojG4jHC8gzkwdGVJuzpmhNJXXJWDQ
 0kJ6dKZoLZKGEb0mNmb286oH38Yka0lEgWgjU1Z7vmz4YSSrNGvnMUFWAOnjyhoU637pZj
 2stH0AYgUAkaqGX9sQH7KOCCFpOSWMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-yq_OfL5MPOGvWLd5Bn-5ug-1; Thu, 01 Apr 2021 09:55:29 -0400
X-MC-Unique: yq_OfL5MPOGvWLd5Bn-5ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368F41084CA4;
 Thu,  1 Apr 2021 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E0395D6B1;
 Thu,  1 Apr 2021 13:55:02 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH v2 1/9] scripts/gdb: rework lx-symbols gdb script
Date: Thu,  1 Apr 2021 16:54:43 +0300
Message-Id: <20210401135451.1004564-2-mlevitsk@redhat.com>
In-Reply-To: <20210401135451.1004564-1-mlevitsk@redhat.com>
References: <20210401135451.1004564-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mailman-Approved-At: Thu, 01 Apr 2021 10:08:09 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 KVM/arm64"
 <kvmarm@lists.cs.columbia.edu>, "open list:S390" <linux-s390@vger.kernel.org>,
 Janosch Frank <frankja@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Kieran Bingham <kbingham@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 KVM/arm64"
 <linux-arm-kernel@lists.infradead.org>, Jim Mattson <jmattson@google.com>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Fix several issues that are present in lx-symbols script:

* Track module unloads by placing another software breakpoint at
  'free_module'
  (force uninline this symbol just in case), and use remove-symbol-file
  gdb command to unload the symobls of the module that is unloading.

  That gives the gdb a chance to mark all software breakpoints from
  this module as pending again.
  Also remove the module from the 'known' module list once it is unloaded.

* Since we now track module unload, we don't need to reload all
  symbols anymore when 'known' module loaded again
  (that can't happen anymore).
  This allows reloading a module in the debugged kernel to finish
  much faster, while lx-symbols tracks module loads and unloads.

* Disable/enable all gdb breakpoints on both module load and unload
  breakpoint hits, and not only in 'load_all_symbols' as was done before.
  (load_all_symbols is no longer called on breakpoint hit)
  That allows gdb to avoid getting confused about the state of the
  (now two) internal breakpoints we place.
  Otherwise it will leave them in the kernel code segment, when
  continuing which triggers a guest kernel panic as soon as it skips
  over the 'int3' instruction and executes the garbage tail of the optcode
  on which the breakpoint was placed.

* Block SIGINT while symbols are reloading as this seems to crash gdb.
  (new in V2)

* Add a basic check that kernel is already loaded into the guest memory
  to avoid confusing errors.
  (new in V2)

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 kernel/module.c              |   8 +-
 scripts/gdb/linux/symbols.py | 203 +++++++++++++++++++++++------------
 2 files changed, 143 insertions(+), 68 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..ea81fc06ea1f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -901,8 +901,12 @@ int module_refcount(struct module *mod)
 }
 EXPORT_SYMBOL(module_refcount);
 
-/* This exists whether we can unload or not */
-static void free_module(struct module *mod);
+/* This exists whether we can unload or not
+ * Keep it uninlined to provide a reliable breakpoint target,
+ * e.g. for the gdb helper command 'lx-symbols'.
+ */
+
+static noinline void free_module(struct module *mod);
 
 SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 		unsigned int, flags)
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 1be9763cf8bb..e1374a6e06f7 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -14,45 +14,23 @@
 import gdb
 import os
 import re
+import signal
 
 from linux import modules, utils
 
 
 if hasattr(gdb, 'Breakpoint'):
-    class LoadModuleBreakpoint(gdb.Breakpoint):
-        def __init__(self, spec, gdb_command):
-            super(LoadModuleBreakpoint, self).__init__(spec, internal=True)
+
+    class BreakpointWrapper(gdb.Breakpoint):
+        def __init__(self, callback, **kwargs):
+            super(BreakpointWrapper, self).__init__(internal=True, **kwargs)
             self.silent = True
-            self.gdb_command = gdb_command
+            self.callback = callback
 
         def stop(self):
-            module = gdb.parse_and_eval("mod")
-            module_name = module['name'].string()
-            cmd = self.gdb_command
-
-            # enforce update if object file is not found
-            cmd.module_files_updated = False
-
-            # Disable pagination while reporting symbol (re-)loading.
-            # The console input is blocked in this context so that we would
-            # get stuck waiting for the user to acknowledge paged output.
-            show_pagination = gdb.execute("show pagination", to_string=True)
-            pagination = show_pagination.endswith("on.\n")
-            gdb.execute("set pagination off")
-
-            if module_name in cmd.loaded_modules:
-                gdb.write("refreshing all symbols to reload module "
-                          "'{0}'\n".format(module_name))
-                cmd.load_all_symbols()
-            else:
-                cmd.load_module_symbols(module)
-
-            # restore pagination state
-            gdb.execute("set pagination %s" % ("on" if pagination else "off"))
-
+            self.callback()
             return False
 
-
 class LxSymbols(gdb.Command):
     """(Re-)load symbols of Linux kernel and currently loaded modules.
 
@@ -61,15 +39,52 @@ are scanned recursively, starting in the same directory. Optionally, the module
 search path can be extended by a space separated list of paths passed to the
 lx-symbols command."""
 
-    module_paths = []
-    module_files = []
-    module_files_updated = False
-    loaded_modules = []
-    breakpoint = None
-
     def __init__(self):
         super(LxSymbols, self).__init__("lx-symbols", gdb.COMMAND_FILES,
                                         gdb.COMPLETE_FILENAME)
+        self.module_paths = []
+        self.module_files = []
+        self.module_files_updated = False
+        self.loaded_modules = {}
+        self.internal_breakpoints = []
+
+    # prepare GDB for loading/unloading a module
+    def _prepare_for_module_load_unload(self):
+
+        self.blocked_sigint = False
+
+        # block SIGINT during execution to avoid gdb crash
+        sigmask = signal.pthread_sigmask(signal.SIG_BLOCK, [])
+        if not signal.SIGINT in sigmask:
+            self.blocked_sigint = True
+            signal.pthread_sigmask(signal.SIG_BLOCK, {signal.SIGINT})
+
+        # disable all breakpoints to workaround a GDB bug where it would
+        # not correctly resume from an internal breakpoint we placed
+        # in do_module_init/free_module (it leaves the int3
+        self.saved_breakpoints = []
+        if hasattr(gdb, 'breakpoints') and not gdb.breakpoints() is None:
+            for bp in gdb.breakpoints():
+                self.saved_breakpoints.append({'breakpoint': bp, 'enabled': bp.enabled})
+                bp.enabled = False
+
+        # disable pagination to avoid asking user for continue
+        show_pagination = gdb.execute("show pagination", to_string=True)
+        self.saved_pagination = show_pagination.endswith("on.\n")
+        gdb.execute("set pagination off")
+
+    def _unprepare_for_module_load_unload(self):
+        # restore breakpoint state
+        for breakpoint in self.saved_breakpoints:
+            breakpoint['breakpoint'].enabled = breakpoint['enabled']
+
+        # restore pagination state
+        gdb.execute("set pagination %s" % ("on" if self.saved_pagination else "off"))
+
+        # unblock SIGINT
+        if self.blocked_sigint:
+            sigmask = signal.pthread_sigmask(signal.SIG_UNBLOCK, {signal.SIGINT})
+            self.blocked_sigint = False
 
     def _update_module_files(self):
         self.module_files = []
@@ -107,7 +122,7 @@ lx-symbols command."""
                     name=section_name, addr=str(address)))
         return "".join(args)
 
-    def load_module_symbols(self, module):
+    def _do_load_module_symbols(self, module):
         module_name = module['name'].string()
         module_addr = str(module['core_layout']['base']).split()[0]
 
@@ -130,55 +145,111 @@ lx-symbols command."""
                 addr=module_addr,
                 sections=self._section_arguments(module))
             gdb.execute(cmdline, to_string=True)
-            if module_name not in self.loaded_modules:
-                self.loaded_modules.append(module_name)
+
+            self.loaded_modules[module_name] = {"module_file": module_file,
+                                                "module_addr": module_addr}
         else:
             gdb.write("no module object found for '{0}'\n".format(module_name))
 
+
+    def load_module_symbols(self):
+        module = gdb.parse_and_eval("mod")
+
+                # module already loaded, false alarm
+        # can happen if 'do_init_module' breakpoint is hit multiple times
+        # due to interrupts
+        module_name = module['name'].string()
+        if module_name in self.loaded_modules:
+            gdb.write("spurious module load breakpoint\n")
+            return
+
+        # enforce update if object file is not found
+        self.module_files_updated = False
+        self._prepare_for_module_load_unload()
+        try:
+            self._do_load_module_symbols(module)
+        finally:
+            self._unprepare_for_module_load_unload()
+
+
+    def unload_module_symbols(self):
+        module = gdb.parse_and_eval("mod")
+        module_name = module['name'].string()
+
+        # module already unloaded, false alarm
+        # can happen if 'free_module' breakpoint is hit multiple times
+        # due to interrupts
+        if not module_name in self.loaded_modules:
+            gdb.write("spurious module unload breakpoint\n")
+            return
+
+        module_file = self.loaded_modules[module_name]["module_file"]
+        module_addr = self.loaded_modules[module_name]["module_addr"]
+
+        self._prepare_for_module_load_unload()
+        try:
+            gdb.write("unloading @{addr}: {filename}\n".format(
+                addr=module_addr, filename=module_file))
+            cmdline = "remove-symbol-file {filename}".format(
+                filename=module_file)
+            gdb.execute(cmdline, to_string=True)
+            del self.loaded_modules[module_name]
+
+        finally:
+            self._unprepare_for_module_load_unload()
+
     def load_all_symbols(self):
         gdb.write("loading vmlinux\n")
 
-        # Dropping symbols will disable all breakpoints. So save their states
-        # and restore them afterward.
-        saved_states = []
-        if hasattr(gdb, 'breakpoints') and not gdb.breakpoints() is None:
-            for bp in gdb.breakpoints():
-                saved_states.append({'breakpoint': bp, 'enabled': bp.enabled})
-
-        # drop all current symbols and reload vmlinux
-        orig_vmlinux = 'vmlinux'
-        for obj in gdb.objfiles():
-            if obj.filename.endswith('vmlinux'):
-                orig_vmlinux = obj.filename
-        gdb.execute("symbol-file", to_string=True)
-        gdb.execute("symbol-file {0}".format(orig_vmlinux))
-
-        self.loaded_modules = []
-        module_list = modules.module_list()
-        if not module_list:
-            gdb.write("no modules found\n")
-        else:
-            [self.load_module_symbols(module) for module in module_list]
+        self._prepare_for_module_load_unload()
+        try:
+            # drop all current symbols and reload vmlinux
+            orig_vmlinux = 'vmlinux'
+            for obj in gdb.objfiles():
+                if obj.filename.endswith('vmlinux'):
+                    orig_vmlinux = obj.filename
+            gdb.execute("symbol-file", to_string=True)
+            gdb.execute("symbol-file {0}".format(orig_vmlinux))
+            self.loaded_modules = {}
+            module_list = modules.module_list()
+            if not module_list:
+                gdb.write("no modules found\n")
+            else:
+                [self._do_load_module_symbols(module) for module in module_list]
+        finally:
+            self._unprepare_for_module_load_unload()
 
-        for saved_state in saved_states:
-            saved_state['breakpoint'].enabled = saved_state['enabled']
+        self._unprepare_for_module_load_unload()
 
     def invoke(self, arg, from_tty):
         self.module_paths = [os.path.expanduser(p) for p in arg.split()]
         self.module_paths.append(os.getcwd())
 
+        try:
+            gdb.parse_and_eval("*start_kernel").fetch_lazy()
+        except gdb.MemoryError:
+            gdb.write("Error: Kernel is not yet loaded\n")
+            return
+
         # enforce update
         self.module_files = []
         self.module_files_updated = False
 
+        for bp in self.internal_breakpoints:
+            bp.delete()
+        self.internal_breakpoints = []
+
         self.load_all_symbols()
 
         if hasattr(gdb, 'Breakpoint'):
-            if self.breakpoint is not None:
-                self.breakpoint.delete()
-                self.breakpoint = None
-            self.breakpoint = LoadModuleBreakpoint(
-                "kernel/module.c:do_init_module", self)
+            self.internal_breakpoints.append(
+                BreakpointWrapper(self.load_module_symbols,
+                                  spec="kernel/module.c:do_init_module",
+                                  ))
+            self.internal_breakpoints.append(
+                BreakpointWrapper(self.unload_module_symbols,
+                                  spec="kernel/module.c:free_module",
+                                  ))
         else:
             gdb.write("Note: symbol update on module loading not supported "
                       "with this gdb version\n")
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

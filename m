Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D32AB4E24B3
	for <lists+kvmarm@lfdr.de>; Mon, 21 Mar 2022 11:51:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AD6549EF3;
	Mon, 21 Mar 2022 06:51:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.607
X-Spam-Level: 
X-Spam-Status: No, score=0.607 required=6.1 tests=[BAYES_00=-1.9,
	FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_BLOCKED=0.001,
	SORTED_RECIPS=2.499, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pkCTModAJwsj; Mon, 21 Mar 2022 06:51:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 81A5449E46;
	Mon, 21 Mar 2022 06:51:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A3D0249E57
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Mar 2022 06:25:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V26vEpvt0a2f for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Mar 2022 06:25:19 -0400 (EDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0A73448F9C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Mar 2022 06:25:19 -0400 (EDT)
Received: by mail-il1-f198.google.com with SMTP id
 h13-20020a056e021d8d00b002c7fb1ec601so3338297ila.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Mar 2022 03:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=dfW60HFiHGAShL8WQ035qSGxvkVFI45Rn0aZ23BkU28=;
 b=OrzycIR0QZVXUpGPJ+XnzrG1FpuQ446Zm7GCaF5sZl0RV1CaWz2V0xJICscfIkHufH
 HXNBOApe7FjQm0318HpbvM+19gSl7EQy44HeDSYkdae5fSUa+TcHPNmClAoc4yTQS7Yl
 Kggu5m6xqYfHIUxuJBWObbvpNmk1Erdl3z5Dv98eNrACuiiD6n61HG8wkJa0Tj9QOMB3
 Nr0U4WbpB+Lby2xijPk8fV72KeqeJ5ddJsIXYMO8kTGqNWFXW100sjAWD3hKgSrQ3sCg
 QALBHnOkNxhstKXJQocIKeOxU1fu63ArATVaNa3Ce6PqrteSBHWxxDijyujaPrxmt59P
 ITag==
X-Gm-Message-State: AOAM533g8O0fYLyFS2AR1kgNeIsy8JVVx+acuwy64w7dMi9BFvwhRlsx
 fK5zcZZ3TQ9L+jiV/2nviIEVHElkOCXQ4HoHuOGGXX/pEGLn
X-Google-Smtp-Source: ABdhPJzTTfOJKl5sHEqG/aH+fRC99gL8AQSHgsFCfD+Y3/oMzeqUJ5gW/d/Cnhwf0JiDWw7bg0Os01JLLPMauK0QHoCaDBrPR/j2
MIME-Version: 1.0
X-Received: by 2002:a5d:8796:0:b0:645:bd36:3833 with SMTP id
 f22-20020a5d8796000000b00645bd363833mr9579909ion.158.1647858318498; Mon, 21
 Mar 2022 03:25:18 -0700 (PDT)
Date: Mon, 21 Mar 2022 03:25:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6df0f05dab7e92c@google.com>
Subject: [syzbot] WARNING in kvm_mmu_notifier_invalidate_range_start (2)
From: syzbot <syzbot+6bde52d89cfdf9f61425@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, aleksandar.qemu.devel@gmail.com, 
 alexandru.elisei@arm.com, benh@kernel.crashing.org, borntraeger@linux.ibm.com, 
 bp@alien8.de, catalin.marinas@arm.com, chenhuacai@kernel.org, 
 dave.hansen@linux.intel.com, david@redhat.com, dja@axtens.net, 
 frankja@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, hpa@zytor.com, 
 imbrenda@linux.ibm.com, james.morse@arm.com, jmattson@google.com, 
 joro@8bytes.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, lukas.bulwahn@gmail.com, 
 maciej.szmigiero@oracle.com, maz@kernel.org, mingo@redhat.com, 
 mpe@ellerman.id.au, paulus@samba.org, pbonzini@redhat.com, seanjc@google.com, 
 suzuki.poulose@arm.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
 tsbogend@alpha.franken.de, vkuznets@redhat.com, wanpengli@tencent.com, 
 will@kernel.org, x86@kernel.org
X-Mailman-Approved-At: Mon, 21 Mar 2022 06:51:28 -0400
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

Hello,

syzbot found the following issue on:

HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13821b8d700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=6bde52d89cfdf9f61425
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a2d0a9700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d34fd9700000

The issue was bisected to:

commit ed922739c9199bf515a3e7fec3e319ce1edeef2a
Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Date:   Mon Dec 6 19:54:28 2021 +0000

    KVM: Use interval tree to do fast hva lookup in memslots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142aa59d700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=162aa59d700000
console output: https://syzkaller.appspot.com/x/log.txt?x=122aa59d700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bde52d89cfdf9f61425@syzkaller.appspotmail.com
Fixes: ed922739c919 ("KVM: Use interval tree to do fast hva lookup in memslots")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3599 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:529 __kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:529 [inline]
WARNING: CPU: 0 PID: 3599 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:529 kvm_mmu_notifier_invalidate_range_start+0x97a/0xb20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:714
Modules linked in:
CPU: 0 PID: 3599 Comm: syz-executor221 Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:529 [inline]
RIP: 0010:kvm_mmu_notifier_invalidate_range_start+0x97a/0xb20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:714
Code: 00 48 c7 c2 60 0c a2 89 be b9 01 00 00 48 c7 c7 c0 10 a2 89 c6 05 ed 71 76 0c 01 e8 79 84 ff 07 e9 73 ff ff ff e8 b6 cd 6f 00 <0f> 0b e9 88 fc ff ff e8 aa cd 6f 00 0f 0b e9 58 fc ff ff e8 9e cd
RSP: 0018:ffffc90001caf948 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000002000d000 RCX: 0000000000000000
RDX: ffff888020d83a00 RSI: ffffffff8108f27a RDI: 0000000000000003
RBP: ffffc90002b76290 R08: 000000002000d000 R09: ffffc90002b762e3
R10: ffffffff8108eb1c R11: 0000000000000001 R12: ffffc90002b7f240
R13: ffffc90002b75000 R14: ffffc90001cafc18 R15: 000000002000d000
FS:  0000555555a55300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000088 CR3: 0000000074ce9000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mn_hlist_invalidate_range_start mm/mmu_notifier.c:493 [inline]
 __mmu_notifier_invalidate_range_start+0x2ff/0x800 mm/mmu_notifier.c:548
 mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:459 [inline]
 move_page_tables+0x2642/0x2d20 mm/mremap.c:498
 move_vma+0x48c/0xf40 mm/mremap.c:629
 mremap_to mm/mremap.c:862 [inline]
 __do_sys_mremap+0xf01/0x1560 mm/mremap.c:972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f11faab5089
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc17608428 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f11faab5089
RDX: 0000000000001000 RSI: fffffffffffffe74 RDI: 000000002000d000
RBP: 00007f11faa79070 R08: 0000000020007000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007f11faa79100
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

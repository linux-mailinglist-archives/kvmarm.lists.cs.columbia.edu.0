Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B11AF901
	for <lists+kvmarm@lfdr.de>; Sun, 19 Apr 2020 11:38:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C82A4B1A3;
	Sun, 19 Apr 2020 05:38:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DO3T4M-fvljS; Sun, 19 Apr 2020 05:38:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D65E4B115;
	Sun, 19 Apr 2020 05:38:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EAAB4B177
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Apr 2020 03:31:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhiKs8gO33la for <kvmarm@lists.cs.columbia.edu>;
 Sun, 19 Apr 2020 03:31:00 -0400 (EDT)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 094EF4B17C
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Apr 2020 03:30:59 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01358;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0TvywI99_1587281447; 
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0TvywI99_1587281447) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 19 Apr 2020 15:30:48 +0800
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To: pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 heiko.carstens@de.ibm.com, gor@linux.ibm.com,
 sean.j.christopherson@intel.com, vkuznets@redhat.com,
 wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, maz@kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com
Subject: [PATCH] KVM: X86: Fix compile error in svm/sev.c
Date: Sun, 19 Apr 2020 15:30:47 +0800
Message-Id: <20200419073047.14413-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 19 Apr 2020 05:38:13 -0400
Cc: linux-s390@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
 kvm@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

VGhlIGNvbXBpbGVyIHJlcG9ydGVkIHRoZSBmb2xsb3dpbmcgY29tcGlsYXRpb24gZXJyb3JzOgoK
YXJjaC94ODYva3ZtL3N2bS9zZXYuYzogSW4gZnVuY3Rpb24g4oCYc2V2X3Bpbl9tZW1vcnnigJk6
CmFyY2gveDg2L2t2bS9zdm0vc2V2LmM6MzYxOjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbgrigJhyZWxlYXNlX3BhZ2Vz4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQogICByZWxlYXNlX3BhZ2VzKHBhZ2VzLCBucGlubmVkKTsKICAgXn5+
fn5+fn5+fn5+fgoKVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSAncGFnZW1hcC5oJyBoZWFkZXIgZmls
ZSBpcyBub3QgaW5jbHVkZWQuCgpTaWduZWQtb2ZmLWJ5OiBUaWFuamlhIFpoYW5nIDx0aWFuamlh
LnpoYW5nQGxpbnV4LmFsaWJhYmEuY29tPgotLS0KIGFyY2gveDg2L2t2bS9zdm0vc2V2LmMgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS9zdm0vc2V2LmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL3Nldi5jCmluZGV4IDBlM2ZjMzExZDdk
YS4uM2VmOTllODdjMWRiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3Nldi5jCisrKyBi
L2FyY2gveDg2L2t2bS9zdm0vc2V2LmMKQEAgLTEzLDYgKzEzLDcgQEAKICNpbmNsdWRlIDxsaW51
eC9oaWdobWVtLmg+CiAjaW5jbHVkZSA8bGludXgvcHNwLXNldi5oPgogI2luY2x1ZGUgPGxpbnV4
L3N3YXAuaD4KKyNpbmNsdWRlIDxsaW51eC9wYWdlbWFwLmg+CiAKICNpbmNsdWRlICJ4ODYuaCIK
ICNpbmNsdWRlICJzdm0uaCIKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3Mu
Y29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGlu
Zm8va3ZtYXJtCg==

Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB161A85B2
	for <lists+kvmarm@lfdr.de>; Tue, 14 Apr 2020 18:50:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB5514B227;
	Tue, 14 Apr 2020 12:49:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 62OzWTmVCbe1; Tue, 14 Apr 2020 12:49:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AB7984B206;
	Tue, 14 Apr 2020 12:49:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 093544B1FB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Apr 2020 12:49:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pfae6yjscXVx for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Apr 2020 12:49:04 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 69B8F4B1E2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Apr 2020 12:49:04 -0400 (EDT)
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de
 [95.90.212.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B77E221707;
 Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586882943;
 bh=/za7QfBY5rqfFy5Fc86zEguQvM3DZ41F1j+QsDC5kAY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=18cIArH6DXxU2OJ7VAhhT0Oy+EKeR+tfw6E5xIUpRL5V8ddsuhMLT48Erei4c3gDM
 tvhG3yXJfvBOm9iq2ahkTD9V91IjPPU9rbuNZunNSqvgAg6fWbRGOj5K1nYNPXbmyd
 /aO1hK/3xZsi5odLBnhFOp6+qU3IJ8xm2ZLq4gTo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
 (envelope-from <mchehab@kernel.org>)
 id 1jOOk8-0068ld-Q4; Tue, 14 Apr 2020 18:49:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH v2 09/33] docs: fix broken references to text files
Date: Tue, 14 Apr 2020 18:48:35 +0200
Message-Id: <6f919ddb83a33b5f2a63b6b5f0575737bb2b36aa.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 14 Apr 2020 12:49:54 -0400
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Akira Yokosawa <akiyks@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-unionfs@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 linux-mm@kvack.org, Harry Wei <harryxiyou@gmail.com>,
 Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Doug Ledford <dledford@redhat.com>,
 Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org,
 Federico Vaga <federico.vaga@vaga.pv.it>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Daniel Lustig <dlustig@nvidia.com>, Mike Leach <mike.leach@linaro.org>,
 Andrea Parri <parri.andrea@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Nicholas Piggin <npiggin@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Luc Maranget <luc.maranget@inria.fr>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 David Howells <dhowells@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-rdma@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Marc Zyngier <maz@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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

U2V2ZXJhbCByZWZlcmVuY2VzIGdvdCBicm9rZW4gZHVlIHRvIHR4dCB0byBSZVNUIGNvbnZlcnNp
b24uCgpTZXZlcmFsIG9mIHRoZW0gY2FuIGJlIGF1dG9tYXRpY2FsbHkgZml4ZWQgd2l0aDoKCglz
Y3JpcHRzL2RvY3VtZW50YXRpb24tZmlsZS1yZWYtY2hlY2sgLS1maXgKClJldmlld2VkLWJ5OiBN
YXRoaWV1IFBvaXJpZXIgPG1hdGhpZXUucG9pcmllckBsaW5hcm8ub3JnPiAjIGh3dHJhY2luZy9j
b3Jlc2lnaHQvS2NvbmZpZwpSZXZpZXdlZC1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0Br
ZXJuZWwub3JnPiAjIG1lbW9yeS1iYXJyaWVyLnR4dApBY2tlZC1ieTogQWxleCBTaGkgPGFsZXgu
c2hpQGxpbnV4LmFsaWJhYmEuY29tPiAjIHRyYW5zbGF0aW9ucy96aF9DTgpBY2tlZC1ieTogRmVk
ZXJpY28gVmFnYSA8ZmVkZXJpY28udmFnYUB2YWdhLnB2Lml0PiAjIHRyYW5zbGF0aW9ucy9pdF9J
VApBY2tlZC1ieTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4gIyBrdm0vYXJtNjQKU2ln
bmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwu
b3JnPgotLS0KIERvY3VtZW50YXRpb24vbWVtb3J5LWJhcnJpZXJzLnR4dCAgICAgICAgICAgICAg
ICAgICAgfCAgMiArLQogRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdC1jaGVja2xpc3QucnN0
ICAgICAgICAgICB8ICAyICstCiAuLi4vdHJhbnNsYXRpb25zL2l0X0lUL3Byb2Nlc3Mvc3VibWl0
LWNoZWNrbGlzdC5yc3QgIHwgIDIgKy0KIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tS
L21lbW9yeS1iYXJyaWVycy50eHQgfCAgMiArLQogLi4uL3RyYW5zbGF0aW9ucy96aF9DTi9maWxl
c3lzdGVtcy9zeXNmcy50eHQgICAgICAgICB8ICAyICstCiAuLi4vdHJhbnNsYXRpb25zL3poX0NO
L3Byb2Nlc3Mvc3VibWl0LWNoZWNrbGlzdC5yc3QgIHwgIDIgKy0KIERvY3VtZW50YXRpb24vdmly
dC9rdm0vYXJtL3B2dGltZS5yc3QgICAgICAgICAgICAgICAgfCAgMiArLQogRG9jdW1lbnRhdGlv
bi92aXJ0L2t2bS9kZXZpY2VzL3ZjcHUucnN0ICAgICAgICAgICAgICB8ICAyICstCiBEb2N1bWVu
dGF0aW9uL3ZpcnQva3ZtL2h5cGVyY2FsbHMucnN0ICAgICAgICAgICAgICAgIHwgIDQgKystLQog
YXJjaC9wb3dlcnBjL2luY2x1ZGUvdWFwaS9hc20va3ZtX3BhcmEuaCAgICAgICAgICAgICB8ICAy
ICstCiBkcml2ZXJzL2dwdS9kcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9kcm1faW9jdGwuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMiArLQogZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L0tjb25maWcgICAgICAg
ICAgICAgICAgICB8ICAyICstCiBmcy9mYXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0KIGZzL2Z1c2UvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQogZnMvZnVzZS9kZXYuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCiBmcy9vdmVybGF5ZnMvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrLS0tCiBpbmNsdWRl
L2xpbnV4L21tLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKystLQog
aW5jbHVkZS91YXBpL2xpbnV4L2V0aHRvb2xfbmV0bGluay5oICAgICAgICAgICAgICAgICB8ICAy
ICstCiBpbmNsdWRlL3VhcGkvcmRtYS9yZG1hX3VzZXJfaW9jdGxfY21kcy5oICAgICAgICAgICAg
IHwgIDIgKy0KIG1tL2d1cC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxMiArKysrKystLS0tLS0KIHZpcnQva3ZtL2FybS92Z2ljL3ZnaWMtbW1pby12My5j
ICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQogdmlydC9rdm0vYXJtL3ZnaWMvdmdpYy5oICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrLS0KIDIzIGZpbGVzIGNoYW5nZWQsIDM2
IGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vbWVtb3J5LWJhcnJpZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vbWVtb3J5LWJhcnJpZXJzLnR4
dAppbmRleCBlMWMzNTVlODRlZGQuLmVhYWJjMzEzNDI5NCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRh
dGlvbi9tZW1vcnktYmFycmllcnMudHh0CisrKyBiL0RvY3VtZW50YXRpb24vbWVtb3J5LWJhcnJp
ZXJzLnR4dApAQCAtNjIwLDcgKzYyMCw3IEBAIGJlY2F1c2UgdGhlIENQVXMgdGhhdCB0aGUgTGlu
dXgga2VybmVsIHN1cHBvcnRzIGRvbid0IGRvIHdyaXRlcwogdW50aWwgdGhleSBhcmUgY2VydGFp
biAoMSkgdGhhdCB0aGUgd3JpdGUgd2lsbCBhY3R1YWxseSBoYXBwZW4sICgyKQogb2YgdGhlIGxv
Y2F0aW9uIG9mIHRoZSB3cml0ZSwgYW5kICgzKSBvZiB0aGUgdmFsdWUgdG8gYmUgd3JpdHRlbi4K
IEJ1dCBwbGVhc2UgY2FyZWZ1bGx5IHJlYWQgdGhlICJDT05UUk9MIERFUEVOREVOQ0lFUyIgc2Vj
dGlvbiBhbmQgdGhlCi1Eb2N1bWVudGF0aW9uL1JDVS9yY3VfZGVyZWZlcmVuY2UudHh0IGZpbGU6
ICBUaGUgY29tcGlsZXIgY2FuIGFuZCBkb2VzCitEb2N1bWVudGF0aW9uL1JDVS9yY3VfZGVyZWZl
cmVuY2UucnN0IGZpbGU6ICBUaGUgY29tcGlsZXIgY2FuIGFuZCBkb2VzCiBicmVhayBkZXBlbmRl
bmNpZXMgaW4gYSBncmVhdCBtYW55IGhpZ2hseSBjcmVhdGl2ZSB3YXlzLgogCiAJQ1BVIDEJCSAg
ICAgIENQVSAyCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0LWNoZWNr
bGlzdC5yc3QgYi9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0LWNoZWNrbGlzdC5yc3QKaW5k
ZXggOGU1NjMzN2Q0MjJkLi4zZjhlOWQ1ZDk1YzIgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24v
cHJvY2Vzcy9zdWJtaXQtY2hlY2tsaXN0LnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
c3VibWl0LWNoZWNrbGlzdC5yc3QKQEAgLTEwNyw3ICsxMDcsNyBAQCBhbmQgZWxzZXdoZXJlIHJl
Z2FyZGluZyBzdWJtaXR0aW5nIExpbnV4IGtlcm5lbCBwYXRjaGVzLgogICAgIGFuZCB3aHkuCiAK
IDI2KSBJZiBhbnkgaW9jdGwncyBhcmUgYWRkZWQgYnkgdGhlIHBhdGNoLCB0aGVuIGFsc28gdXBk
YXRlCi0gICAgYGBEb2N1bWVudGF0aW9uL2lvY3RsL2lvY3RsLW51bWJlci5yc3RgYC4KKyAgICBg
YERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0YGAuCiAK
IDI3KSBJZiB5b3VyIG1vZGlmaWVkIHNvdXJjZSBjb2RlIGRlcGVuZHMgb24gb3IgdXNlcyBhbnkg
b2YgdGhlIGtlcm5lbAogICAgIEFQSXMgb3IgZmVhdHVyZXMgdGhhdCBhcmUgcmVsYXRlZCB0byB0
aGUgZm9sbG93aW5nIGBgS2NvbmZpZ2BgIHN5bWJvbHMsCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL3RyYW5zbGF0aW9ucy9pdF9JVC9wcm9jZXNzL3N1Ym1pdC1jaGVja2xpc3QucnN0IGIvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvaXRfSVQvcHJvY2Vzcy9zdWJtaXQtY2hlY2tsaXN0LnJz
dAppbmRleCA5OTVlZTY5ZmFiMTEuLjNlNTc1NTAyNjkwZiAxMDA2NDQKLS0tIGEvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvaXRfSVQvcHJvY2Vzcy9zdWJtaXQtY2hlY2tsaXN0LnJzdAorKysg
Yi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9pdF9JVC9wcm9jZXNzL3N1Ym1pdC1jaGVja2xp
c3QucnN0CkBAIC0xMTcsNyArMTE3LDcgQEAgc290dG9taXNzaW9uZSBkZWxsZSBwYXRjaCwgaW4g
cGFydGljb2xhcmUKICAgICBzb3JnZW50aSBjaGUgbmUgc3BpZWdoaSBsYSBsb2dpY2E6IGNvc2Eg
ZmFubm8gZSBwZXJjaMOpLgogCiAyNSkgU2UgbGEgcGF0Y2ggYWdnaXVuZ2UgbnVvdmUgY2hpYW1h
dGUgaW9jdGwsIGFsbG9yYSBhZ2dpb3JuYXRlCi0gICAgYGBEb2N1bWVudGF0aW9uL2lvY3RsL2lv
Y3RsLW51bWJlci5yc3RgYC4KKyAgICBgYERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9pb2N0
bC9pb2N0bC1udW1iZXIucnN0YGAuCiAKIDI2KSBTZSBpbCBjb2RpY2UgY2hlIGF2ZXRlIG1vZGlm
aWNhdG8gZGlwZW5kZSBvIHVzYSB1bmEgcXVhbHNpYXNpIGludGVyZmFjY2lhIG8KICAgICBmdW56
aW9uYWxpdMOgIGRlbCBrZXJuZWwgY2hlIMOoIGFzc29jaWF0YSBhIHVubyBkZWkgc2VndWVudGkg
c2ltYm9saQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvbWVt
b3J5LWJhcnJpZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL21lbW9y
eS1iYXJyaWVycy50eHQKaW5kZXggMmU4MzFlY2U2ZTI2Li5lNTBmZTY1NDEzMzUgMTAwNjQ0Ci0t
LSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL21lbW9yeS1iYXJyaWVycy50eHQK
KysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvbWVtb3J5LWJhcnJpZXJzLnR4
dApAQCAtNjQxLDcgKzY0MSw3IEBAIFAg64qUIOynneyImCDrsojtmLgg7LqQ7IucIOudvOyduOyX
kCDsoIDsnqXrkJjslrQg7J6I6rOgLCDrs4DsiJggQiDripQg7ZmA7IiYIAog66as64iF7IqkIOy7
pOuEkOydtCDsp4Dsm5DtlZjripQgQ1BVIOuTpOydgCAoMSkg7JOw6riw6rCAIOygleunkOuhnCDs
nbzslrTrgqDsp4AsICgyKSDsk7DquLDqsIAg7Ja065SU7JeQCiDsnbTro6jslrTsp4jsp4AsIOq3
uOumrOqzoCAoMykg7JOw7Jes7KeIIOqwkuydhCDtmZXsi6Ttnogg7JWM6riwIOyghOq5jOyngOuK
lCDsk7DquLDrpbwg7IiY7ZaJ7ZWY7KeAIOyViuq4sAog65WM66y47J6F64uI64ukLiAg7ZWY7KeA
66eMICLsu6jtirjroaQg7J2Y7KG07ISxIiDshLnshZjqs7wKLURvY3VtZW50YXRpb24vUkNVL3Jj
dV9kZXJlZmVyZW5jZS50eHQg7YyM7J287J2EIOyjvOydmCDquYrqsowg7J297Ja0IOyjvOyLnOq4
sCDrsJTrno3ri4jri6Q6CitEb2N1bWVudGF0aW9uL1JDVS9yY3VfZGVyZWZlcmVuY2UucnN0IO2M
jOydvOydhCDso7zsnZgg6rmK6rKMIOydveyWtCDso7zsi5zquLAg67CU656N64uI64ukOgog7Lu0
7YyM7J2865+s64qUIOunpOyasCDssL3snZjsoIHsnbgg66eO7J2AIOuwqeuyleycvOuhnCDsooXs
ho3shLHsnYQg6rmwIOyImCDsnojsirXri4jri6QuCiAKIAlDUFUgMQkJICAgICAgQ1BVIDIKZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2ZpbGVzeXN0ZW1zL3N5
c2ZzLnR4dCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2ZpbGVzeXN0ZW1zL3N5
c2ZzLnR4dAppbmRleCBlZTFmMzdkYTViMjMuLmExNWMzZWJkZmE4MiAxMDA2NDQKLS0tIGEvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vZmlsZXN5c3RlbXMvc3lzZnMudHh0CisrKyBi
L0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2ZpbGVzeXN0ZW1zL3N5c2ZzLnR4dApA
QCAtMjgxLDcgKzI4MSw3IEBAIGRyaXZlcnMvIOWMheWQq+S6huavj+S4quW3suS4uueJueWumuaA
u+e6v+S4iueahOiuvuWkh+iAjOaMgui9veeahOmpseWKqOeoi+W6jwog5YGH5a6a6amx5Yqo5rKh
5pyJ6Leo6LaK5aSa5Liq5oC757q/57G75Z6LKeOAggogCiBmcy8g5YyF5ZCr5LqG5LiA5Liq5Li6
5paH5Lu257O757uf6K6+56uL55qE55uu5b2V44CC546w5Zyo5q+P5Liq5oOz6KaB5a+85Ye65bGe
5oCn55qE5paH5Lu257O757uf5b+F6aG7Ci3lnKggZnMvIOS4i+WIm+W7uuiHquW3seeahOWxguas
oee7k+aehCjlj4Lop4FEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2Z1c2UudHh0KeOAggor5Zyo
IGZzLyDkuIvliJvlu7roh6rlt7HnmoTlsYLmrKHnu5PmnoQo5Y+C6KeBRG9jdW1lbnRhdGlvbi9m
aWxlc3lzdGVtcy9mdXNlLnJzdCnjgIIKIAogZGV2LyDljIXlkKvkuKTkuKrlrZDnm67lvZXvvJog
Y2hhci8g5ZKMIGJsb2NrL+OAguWcqOi/meS4pOS4quWtkOebruW9leS4re+8jOacieS7pQogPG1h
am9yPjo8bWlub3I+IOagvOW8j+WRveWQjeeahOespuWPt+mTvuaOpeOAgui/meS6m+espuWPt+mT
vuaOpeaMh+WQkSBzeXNmcyDnm67lvZUKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL3poX0NOL3Byb2Nlc3Mvc3VibWl0LWNoZWNrbGlzdC5yc3QgYi9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzL3N1Ym1pdC1jaGVja2xpc3QucnN0CmluZGV4IDg3
MzhjNTVlNDJhMi4uNTAzODZlMGU0MmU3IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9wcm9jZXNzL3N1Ym1pdC1jaGVja2xpc3QucnN0CisrKyBiL0RvY3VtZW50
YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3Mvc3VibWl0LWNoZWNrbGlzdC5yc3QKQEAg
LTk3LDcgKzk3LDcgQEAgTGludXjlhoXmoLjooaXkuIHmj5DkuqTmuIXljZUKIDI0KSDmiYDmnInl
hoXlrZjlsY/pmpzkvovlpoIgYGBiYXJyaWVyKClgYCwgYGBybWIoKWBgLCBgYHdtYigpYGAg6YO9
6ZyA6KaB5rqQ5Luj56CB5Lit55qE5rOoCiAgICAg6YeK5p2l6Kej6YeK5a6D5Lus5q2j5Zyo5omn
6KGM55qE5pON5L2c5Y+K5YW25Y6f5Zug55qE6YC76L6R44CCCiAKLTI1KSDlpoLmnpzooaXkuIHm
t7vliqDkuobku7vkvZVpb2N0bO+8jOmCo+S5iOS5n+imgeabtOaWsCBgYERvY3VtZW50YXRpb24v
aW9jdGwvaW9jdGwtbnVtYmVyLnJzdGBgCisyNSkg5aaC5p6c6KGl5LiB5re75Yqg5LqG5Lu75L2V
aW9jdGzvvIzpgqPkuYjkuZ/opoHmm7TmlrAgYGBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkv
aW9jdGwvaW9jdGwtbnVtYmVyLnJzdGBgCiAKIDI2KSDlpoLmnpzkv67mlLnlkI7nmoTmupDku6Pn
oIHkvp3otZbmiJbkvb/nlKjkuI7ku6XkuIsgYGBLY29uZmlnYGAg56ym5Y+355u45YWz55qE5Lu7
5L2V5YaF5qC4QVBJ5oiWCiAgICAg5Yqf6IO977yM5YiZ5Zyo56aB55So55u45YWzIGBgS2NvbmZp
Z2BgIOespuWPt+WSjC/miJYgYGA9bWBgIO+8iOWmguaenOivpemAiemhueWPr+eUqO+8ieeahOaD
heWGtQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9hcm0vcHZ0aW1lLnJzdCBi
L0RvY3VtZW50YXRpb24vdmlydC9rdm0vYXJtL3B2dGltZS5yc3QKaW5kZXggMjM1N2RkMmQ4NjU1
Li42ODdiNjBkNzZjYTkgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vdmlydC9rdm0vYXJtL3B2
dGltZS5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9hcm0vcHZ0aW1lLnJzdApAQCAt
NzYsNSArNzYsNSBAQCBJdCBpcyBhZHZpc2FibGUgdGhhdCBvbmUgb3IgbW9yZSA2NGsgcGFnZXMg
YXJlIHNldCBhc2lkZSBmb3IgdGhlIHB1cnBvc2Ugb2YKIHRoZXNlIHN0cnVjdHVyZXMgYW5kIG5v
dCB1c2VkIGZvciBvdGhlciBwdXJwb3NlcywgdGhpcyBlbmFibGVzIHRoZSBndWVzdCB0byBtYXAK
IHRoZSByZWdpb24gdXNpbmcgNjRrIHBhZ2VzIGFuZCBhdm9pZHMgY29uZmxpY3RpbmcgYXR0cmli
dXRlcyB3aXRoIG90aGVyIG1lbW9yeS4KIAotRm9yIHRoZSB1c2VyIHNwYWNlIGludGVyZmFjZSBz
ZWUgRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9kZXZpY2VzL3ZjcHUudHh0CitGb3IgdGhlIHVzZXIg
c3BhY2UgaW50ZXJmYWNlIHNlZSBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2RldmljZXMvdmNwdS5y
c3QKIHNlY3Rpb24gIjMuIEdST1VQOiBLVk1fQVJNX1ZDUFVfUFZUSU1FX0NUUkwiLgpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9kZXZpY2VzL3ZjcHUucnN0IGIvRG9jdW1lbnRh
dGlvbi92aXJ0L2t2bS9kZXZpY2VzL3ZjcHUucnN0CmluZGV4IDk5NjNlNjgwNzcwYS4uY2EzNzRk
M2ZlMDg1IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2RldmljZXMvdmNwdS5y
c3QKKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9kZXZpY2VzL3ZjcHUucnN0CkBAIC0xMTAs
NSArMTEwLDUgQEAgUmV0dXJuczoKIAogU3BlY2lmaWVzIHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhl
IHN0b2xlbiB0aW1lIHN0cnVjdHVyZSBmb3IgdGhpcyBWQ1BVLiBUaGUKIGJhc2UgYWRkcmVzcyBt
dXN0IGJlIDY0IGJ5dGUgYWxpZ25lZCBhbmQgZXhpc3Qgd2l0aGluIGEgdmFsaWQgZ3Vlc3QgbWVt
b3J5Ci1yZWdpb24uIFNlZSBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2FybS9wdnRpbWUudHh0IGZv
ciBtb3JlIGluZm9ybWF0aW9uCityZWdpb24uIFNlZSBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2Fy
bS9wdnRpbWUucnN0IGZvciBtb3JlIGluZm9ybWF0aW9uCiBpbmNsdWRpbmcgdGhlIGxheW91dCBv
ZiB0aGUgc3RvbGVuIHRpbWUgc3RydWN0dXJlLgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92
aXJ0L2t2bS9oeXBlcmNhbGxzLnJzdCBiL0RvY3VtZW50YXRpb24vdmlydC9rdm0vaHlwZXJjYWxs
cy5yc3QKaW5kZXggZGJhZjIwN2U1NjBkLi5lZDRmZGRkMzY0ZWEgMTAwNjQ0Ci0tLSBhL0RvY3Vt
ZW50YXRpb24vdmlydC9rdm0vaHlwZXJjYWxscy5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0
L2t2bS9oeXBlcmNhbGxzLnJzdApAQCAtMjIsNyArMjIsNyBAQCBTMzkwOgogICBudW1iZXIgaW4g
UjEuCiAKICAgRm9yIGZ1cnRoZXIgaW5mb3JtYXRpb24gb24gdGhlIFMzOTAgZGlhZ25vc2UgY2Fs
bCBhcyBzdXBwb3J0ZWQgYnkgS1ZNLAotICByZWZlciB0byBEb2N1bWVudGF0aW9uL3ZpcnQva3Zt
L3MzOTAtZGlhZy50eHQuCisgIHJlZmVyIHRvIERvY3VtZW50YXRpb24vdmlydC9rdm0vczM5MC1k
aWFnLnJzdC4KIAogUG93ZXJQQzoKICAgSXQgdXNlcyBSMy1SMTAgYW5kIGh5cGVyY2FsbCBudW1i
ZXIgaW4gUjExLiBSNC1SMTEgYXJlIHVzZWQgYXMgb3V0cHV0IHJlZ2lzdGVycy4KQEAgLTMwLDcg
KzMwLDcgQEAgUG93ZXJQQzoKIAogICBLVk0gaHlwZXJjYWxscyB1c2VzIDQgYnl0ZSBvcGNvZGUs
IHRoYXQgYXJlIHBhdGNoZWQgd2l0aCAnaHlwZXJjYWxsLWluc3RydWN0aW9ucycKICAgcHJvcGVy
dHkgaW5zaWRlIHRoZSBkZXZpY2UgdHJlZSdzIC9oeXBlcnZpc29yIG5vZGUuCi0gIEZvciBtb3Jl
IGluZm9ybWF0aW9uIHJlZmVyIHRvIERvY3VtZW50YXRpb24vdmlydC9rdm0vcHBjLXB2LnR4dAor
ICBGb3IgbW9yZSBpbmZvcm1hdGlvbiByZWZlciB0byBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL3Bw
Yy1wdi5yc3QKIAogTUlQUzoKICAgS1ZNIGh5cGVyY2FsbHMgdXNlIHRoZSBIWVBDQUxMIGluc3Ry
dWN0aW9uIHdpdGggY29kZSAwIGFuZCB0aGUgaHlwZXJjYWxsCmRpZmYgLS1naXQgYS9hcmNoL3Bv
d2VycGMvaW5jbHVkZS91YXBpL2FzbS9rdm1fcGFyYS5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUv
dWFwaS9hc20va3ZtX3BhcmEuaAppbmRleCBiZTQ4YzIyMTVmYTIuLmE4MDliMWI0NGRkZiAxMDA2
NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvdWFwaS9hc20va3ZtX3BhcmEuaAorKysgYi9h
cmNoL3Bvd2VycGMvaW5jbHVkZS91YXBpL2FzbS9rdm1fcGFyYS5oCkBAIC0zMSw3ICszMSw3IEBA
CiAgKiBTdHJ1Y3QgZmllbGRzIGFyZSBhbHdheXMgMzIgb3IgNjQgYml0IGFsaWduZWQsIGRlcGVu
ZGluZyBvbiB0aGVtIGJlaW5nIDMyCiAgKiBvciA2NCBiaXQgd2lkZSByZXNwZWN0aXZlbHkuCiAg
KgotICogU2VlIERvY3VtZW50YXRpb24vdmlydC9rdm0vcHBjLXB2LnR4dAorICogU2VlIERvY3Vt
ZW50YXRpb24vdmlydC9rdm0vcHBjLXB2LnJzdAogICovCiBzdHJ1Y3Qga3ZtX3ZjcHVfYXJjaF9z
aGFyZWQgewogCV9fdTY0IHNjcmF0Y2gxOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL0tj
b25maWcgYi9kcml2ZXJzL2dwdS9kcm0vS2NvbmZpZwppbmRleCA0MzU5NDk3ODk1OGUuLmZiOTJi
ZTdlOGFhNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL0tjb25maWcKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL0tjb25maWcKQEAgLTE2MSw3ICsxNjEsNyBAQCBjb25maWcgRFJNX0xPQURfRURJ
RF9GSVJNV0FSRQogCSAgbW9uaXRvciBhcmUgdW5hYmxlIHRvIHByb3ZpZGUgYXBwcm9wcmlhdGUg
RURJRCBkYXRhLiBTaW5jZSB0aGlzCiAJICBmZWF0dXJlIGlzIHByb3ZpZGVkIGFzIGEgd29ya2Fy
b3VuZCBmb3IgYnJva2VuIGhhcmR3YXJlLCB0aGUKIAkgIGRlZmF1bHQgY2FzZSBpcyBOLiBEZXRh
aWxzIGFuZCBpbnN0cnVjdGlvbnMgaG93IHRvIGJ1aWxkIHlvdXIgb3duCi0JICBFRElEIGRhdGEg
YXJlIGdpdmVuIGluIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9lZGlkLnJzdC4KKwkgIEVESUQg
ZGF0YSBhcmUgZ2l2ZW4gaW4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9lZGlkLnJzdC4KIAog
Y29uZmlnIERSTV9EUF9DRUMKIAlib29sICJFbmFibGUgRGlzcGxheVBvcnQgQ0VDLVR1bm5lbGlu
Zy1vdmVyLUFVWCBIRE1JIHN1cHBvcnQiCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJt
X2lvY3RsLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmMKaW5kZXggOWU0MTk3MmM0YmJj
Li5jMmI4ZDJhOTUzYWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1faW9jdGwuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmMKQEAgLTc0MSw3ICs3NDEsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGRybV9pb2N0bF9kZXNjIGRybV9pb2N0bHNbXSA9IHsKICAqICAgICB9
OwogICoKICAqIFBsZWFzZSBtYWtlIHN1cmUgdGhhdCB5b3UgZm9sbG93IGFsbCB0aGUgYmVzdCBw
cmFjdGljZXMgZnJvbQotICogYGBEb2N1bWVudGF0aW9uL2lvY3RsL2JvdGNoaW5nLXVwLWlvY3Rs
cy5yc3RgYC4gTm90ZSB0aGF0IGRybV9pb2N0bCgpCisgKiBgYERvY3VtZW50YXRpb24vcHJvY2Vz
cy9ib3RjaGluZy11cC1pb2N0bHMucnN0YGAuIE5vdGUgdGhhdCBkcm1faW9jdGwoKQogICogYXV0
b21hdGljYWxseSB6ZXJvLWV4dGVuZHMgc3RydWN0dXJlcywgaGVuY2UgbWFrZSBzdXJlIHlvdSBj
YW4gYWRkIG1vcmUgc3R1ZmYKICAqIGF0IHRoZSBlbmQsIGkuZS4gZG9uJ3QgcHV0IGEgdmFyaWFi
bGUgc2l6ZWQgYXJyYXkgdGhlcmUuCiAgKgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od3RyYWNpbmcv
Y29yZXNpZ2h0L0tjb25maWcgYi9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvS2NvbmZpZwpp
bmRleCA4M2U4NDFiZTEwODEuLjAyZGJiNWNhM2JjZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9od3Ry
YWNpbmcvY29yZXNpZ2h0L0tjb25maWcKKysrIGIvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0
L0tjb25maWcKQEAgLTEwNyw3ICsxMDcsNyBAQCBjb25maWcgQ09SRVNJR0hUX0NQVV9ERUJVRwog
CSAgY2FuIHF1aWNrbHkgZ2V0IHRvIGtub3cgcHJvZ3JhbSBjb3VudGVyIChQQyksIHNlY3VyZSBz
dGF0ZSwKIAkgIGV4Y2VwdGlvbiBsZXZlbCwgZXRjLiBCZWZvcmUgdXNlIGRlYnVnZ2luZyBmdW5j
dGlvbmFsaXR5LCBwbGF0Zm9ybQogCSAgbmVlZHMgdG8gZW5zdXJlIHRoZSBjbG9jayBkb21haW4g
YW5kIHBvd2VyIGRvbWFpbiBhcmUgZW5hYmxlZAotCSAgcHJvcGVybHksIHBsZWFzZSByZWZlciBE
b2N1bWVudGF0aW9uL3RyYWNlL2NvcmVzaWdodC1jcHUtZGVidWcucnN0CisJICBwcm9wZXJseSwg
cGxlYXNlIHJlZmVyIERvY3VtZW50YXRpb24vdHJhY2UvY29yZXNpZ2h0L2NvcmVzaWdodC1jcHUt
ZGVidWcucnN0CiAJICBmb3IgZGV0YWlsZWQgZGVzY3JpcHRpb24gYW5kIHRoZSBleGFtcGxlIGZv
ciB1c2FnZS4KIAogY29uZmlnIENPUkVTSUdIVF9DVEkKZGlmZiAtLWdpdCBhL2ZzL2ZhdC9LY29u
ZmlnIGIvZnMvZmF0L0tjb25maWcKaW5kZXggNzE4MTYzZDBjNjIxLi5jYTMxOTkzZGNiNDcgMTAw
NjQ0Ci0tLSBhL2ZzL2ZhdC9LY29uZmlnCisrKyBiL2ZzL2ZhdC9LY29uZmlnCkBAIC02OSw3ICs2
OSw3IEBAIGNvbmZpZyBWRkFUX0ZTCiAKIAkgIFRoZSBWRkFUIHN1cHBvcnQgZW5sYXJnZXMgeW91
ciBrZXJuZWwgYnkgYWJvdXQgMTAgS0IgYW5kIGl0IG9ubHkKIAkgIHdvcmtzIGlmIHlvdSBzYWlk
IFkgdG8gdGhlICJET1MgRkFUIGZzIHN1cHBvcnQiIGFib3ZlLiAgUGxlYXNlIHJlYWQKLQkgIHRo
ZSBmaWxlIDxmaWxlOkRvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvdmZhdC50eHQ+IGZvciBkZXRh
aWxzLiAgSWYKKwkgIHRoZSBmaWxlIDxmaWxlOkRvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvdmZh
dC5yc3Q+IGZvciBkZXRhaWxzLiAgSWYKIAkgIHVuc3VyZSwgc2F5IFkuCiAKIAkgIFRvIGNvbXBp
bGUgdGhpcyBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlIG1vZHVsZSB3aWxsIGJlIGNh
bGxlZApAQCAtODIsNyArODIsNyBAQCBjb25maWcgRkFUX0RFRkFVTFRfQ09ERVBBR0UKIAloZWxw
CiAJICBUaGlzIG9wdGlvbiBzaG91bGQgYmUgc2V0IHRvIHRoZSBjb2RlcGFnZSBvZiB5b3VyIEZB
VCBmaWxlc3lzdGVtcy4KIAkgIEl0IGNhbiBiZSBvdmVycmlkZGVuIHdpdGggdGhlICJjb2RlcGFn
ZSIgbW91bnQgb3B0aW9uLgotCSAgU2VlIDxmaWxlOkRvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMv
dmZhdC50eHQ+IGZvciBtb3JlIGluZm9ybWF0aW9uLgorCSAgU2VlIDxmaWxlOkRvY3VtZW50YXRp
b24vZmlsZXN5c3RlbXMvdmZhdC5yc3Q+IGZvciBtb3JlIGluZm9ybWF0aW9uLgogCiBjb25maWcg
RkFUX0RFRkFVTFRfSU9DSEFSU0VUCiAJc3RyaW5nICJEZWZhdWx0IGlvY2hhcnNldCBmb3IgRkFU
IgpAQCAtOTYsNyArOTYsNyBAQCBjb25maWcgRkFUX0RFRkFVTFRfSU9DSEFSU0VUCiAJICBOb3Rl
IHRoYXQgInV0ZjgiIGlzIG5vdCByZWNvbW1lbmRlZCBmb3IgRkFUIGZpbGVzeXN0ZW1zLgogCSAg
SWYgdW5zdXJlLCB5b3Ugc2hvdWxkbid0IHNldCAidXRmOCIgaGVyZSAtIHNlbGVjdCB0aGUgbmV4
dCBvcHRpb24KIAkgIGluc3RlYWQgaWYgeW91IHdvdWxkIGxpa2UgdG8gdXNlIFVURi04IGVuY29k
ZWQgZmlsZSBuYW1lcyBieSBkZWZhdWx0LgotCSAgU2VlIDxmaWxlOkRvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvdmZhdC50eHQ+IGZvciBtb3JlIGluZm9ybWF0aW9uLgorCSAgU2VlIDxmaWxlOkRv
Y3VtZW50YXRpb24vZmlsZXN5c3RlbXMvdmZhdC5yc3Q+IGZvciBtb3JlIGluZm9ybWF0aW9uLgog
CiAJICBFbmFibGUgYW55IGNoYXJhY3RlciBzZXRzIHlvdSBuZWVkIGluIEZpbGUgU3lzdGVtcy9O
YXRpdmUgTGFuZ3VhZ2UKIAkgIFN1cHBvcnQuCkBAIC0xMTQsNCArMTE0LDQgQEAgY29uZmlnIEZB
VF9ERUZBVUxUX1VURjgKIAogCSAgU2F5IFkgaWYgeW91IHVzZSBVVEYtOCBlbmNvZGluZyBmb3Ig
ZmlsZSBuYW1lcywgTiBvdGhlcndpc2UuCiAKLQkgIFNlZSA8ZmlsZTpEb2N1bWVudGF0aW9uL2Zp
bGVzeXN0ZW1zL3ZmYXQudHh0PiBmb3IgbW9yZSBpbmZvcm1hdGlvbi4KKwkgIFNlZSA8ZmlsZTpE
b2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3ZmYXQucnN0PiBmb3IgbW9yZSBpbmZvcm1hdGlvbi4K
ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvS2NvbmZpZyBiL2ZzL2Z1c2UvS2NvbmZpZwppbmRleCBlYjJh
NTg1NTcyZGMuLjc3NGIyNjE4MDE4YSAxMDA2NDQKLS0tIGEvZnMvZnVzZS9LY29uZmlnCisrKyBi
L2ZzL2Z1c2UvS2NvbmZpZwpAQCAtMTIsNyArMTIsNyBAQCBjb25maWcgRlVTRV9GUwogCSAgYWx0
aG91Z2ggY2hhbmNlcyBhcmUgeW91ciBkaXN0cmlidXRpb24gYWxyZWFkeSBoYXMgdGhhdCBsaWJy
YXJ5CiAJICBpbnN0YWxsZWQgaWYgeW91J3ZlIGluc3RhbGxlZCB0aGUgImZ1c2UiIHBhY2thZ2Ug
aXRzZWxmLgogCi0JICBTZWUgPGZpbGU6RG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9mdXNlLnR4
dD4gZm9yIG1vcmUgaW5mb3JtYXRpb24uCisJICBTZWUgPGZpbGU6RG9jdW1lbnRhdGlvbi9maWxl
c3lzdGVtcy9mdXNlLnJzdD4gZm9yIG1vcmUgaW5mb3JtYXRpb24uCiAJICBTZWUgPGZpbGU6RG9j
dW1lbnRhdGlvbi9DaGFuZ2VzPiBmb3IgbmVlZGVkIGxpYnJhcnkvdXRpbGl0eSB2ZXJzaW9uLgog
CiAJICBJZiB5b3Ugd2FudCB0byBkZXZlbG9wIGEgdXNlcnNwYWNlIEZTLCBvciBpZiB5b3Ugd2Fu
dCB0byB1c2UKZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2LmMgYi9mcy9mdXNlL2Rldi5jCmluZGV4
IDk3ZWVjNzUyMmJmMi4uYzdhNjVjZjJiY2NhIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rldi5jCisr
KyBiL2ZzL2Z1c2UvZGV2LmMKQEAgLTIwODEsNyArMjA4MSw3IEBAIHN0YXRpYyB2b2lkIGVuZF9w
b2xscyhzdHJ1Y3QgZnVzZV9jb25uICpmYykKICAqIFRoZSBzYW1lIGVmZmVjdCBpcyB1c3VhbGx5
IGFjaGlldmFibGUgdGhyb3VnaCBraWxsaW5nIHRoZSBmaWxlc3lzdGVtIGRhZW1vbgogICogYW5k
IGFsbCB1c2VycyBvZiB0aGUgZmlsZXN5c3RlbS4gIFRoZSBleGNlcHRpb24gaXMgdGhlIGNvbWJp
bmF0aW9uIG9mIGFuCiAgKiBhc3luY2hyb25vdXMgcmVxdWVzdCBhbmQgdGhlIHRyaWNreSBkZWFk
bG9jayAoc2VlCi0gKiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2Z1c2UudHh0KS4KKyAqIERv
Y3VtZW50YXRpb24vZmlsZXN5c3RlbXMvZnVzZS5yc3QpLgogICoKICAqIEFib3J0aW5nIHJlcXVl
c3RzIHVuZGVyIEkvTyBnb2VzIGFzIGZvbGxvd3M6IDE6IFNlcGFyYXRlIG91dCB1bmxvY2tlZAog
ICogcmVxdWVzdHMsIHRoZXkgc2hvdWxkIGJlIGZpbmlzaGVkIG9mZiBpbW1lZGlhdGVseS4gIExv
Y2tlZCByZXF1ZXN0cyB3aWxsIGJlCmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvS2NvbmZpZyBi
L2ZzL292ZXJsYXlmcy9LY29uZmlnCmluZGV4IDcxNGMxNGM0N2NhNS4uZGQxODhjNzk5NmIzIDEw
MDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvS2NvbmZpZworKysgYi9mcy9vdmVybGF5ZnMvS2NvbmZp
ZwpAQCAtOSw3ICs5LDcgQEAgY29uZmlnIE9WRVJMQVlfRlMKIAkgICdsb3dlcicgZmlsZXN5c3Rl
bSBpcyBlaXRoZXIgaGlkZGVuIG9yLCBpbiB0aGUgY2FzZSBvZiBkaXJlY3RvcmllcywKIAkgIG1l
cmdlZCB3aXRoIHRoZSAndXBwZXInIG9iamVjdC4KIAotCSAgRm9yIG1vcmUgaW5mb3JtYXRpb24g
c2VlIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZzLnR4dAorCSAgRm9yIG1vcmUg
aW5mb3JtYXRpb24gc2VlIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZzLnJzdAog
CiBjb25maWcgT1ZFUkxBWV9GU19SRURJUkVDVF9ESVIKIAlib29sICJPdmVybGF5ZnM6IHR1cm4g
b24gcmVkaXJlY3QgZGlyZWN0b3J5IGZlYXR1cmUgYnkgZGVmYXVsdCIKQEAgLTM4LDcgKzM4LDcg
QEAgY29uZmlnIE9WRVJMQVlfRlNfUkVESVJFQ1RfQUxXQVlTX0ZPTExPVwogCSAgSWYgYmFja3dh
cmQgY29tcGF0aWJpbGl0eSBpcyBub3QgYW4gaXNzdWUsIHRoZW4gaXQgaXMgc2FmZSBhbmQKIAkg
IHJlY29tbWVuZGVkIHRvIHNheSBOIGhlcmUuCiAKLQkgIEZvciBtb3JlIGluZm9ybWF0aW9uLCBz
ZWUgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMudHh0CisJICBGb3IgbW9yZSBp
bmZvcm1hdGlvbiwgc2VlIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZzLnJzdAog
CiAJICBJZiB1bnN1cmUsIHNheSBZLgogCkBAIC0xMDMsNyArMTAzLDcgQEAgY29uZmlnIE9WRVJM
QVlfRlNfWElOT19BVVRPCiAJICBJZiBjb21wYXRpYmlsaXR5IHdpdGggYXBwbGljYXRpb25zIHRo
YXQgZXhwZWN0IDMyYml0IGlub2RlcyBpcyBub3QgYW4KIAkgIGlzc3VlLCB0aGVuIGl0IGlzIHNh
ZmUgYW5kIHJlY29tbWVuZGVkIHRvIHNheSBZIGhlcmUuCiAKLQkgIEZvciBtb3JlIGluZm9ybWF0
aW9uLCBzZWUgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMudHh0CisJICBGb3Ig
bW9yZSBpbmZvcm1hdGlvbiwgc2VlIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZz
LnJzdAogCiAJICBJZiB1bnN1cmUsIHNheSBOLgogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgKaW5kZXggNWEzMjM0MjJkNzgzLi4xZjI4NTA0NjVm
NTkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L21t
LmgKQEAgLTEyMTksNyArMTIxOSw3IEBAIHZvaWQgdW5waW5fdXNlcl9wYWdlcyhzdHJ1Y3QgcGFn
ZSAqKnBhZ2VzLCB1bnNpZ25lZCBsb25nIG5wYWdlcyk7CiAgKiB1c2VkIHRvIHRyYWNrIHRoZSBw
aW5jb3VudCAoaW5zdGVhZCB1c2luZyBvZiB0aGUgR1VQX1BJTl9DT1VOVElOR19CSUFTCiAgKiBz
Y2hlbWUpLgogICoKLSAqIEZvciBtb3JlIGluZm9ybWF0aW9uLCBwbGVhc2Ugc2VlIERvY3VtZW50
YXRpb24vdm0vcGluX3VzZXJfcGFnZXMucnN0LgorICogRm9yIG1vcmUgaW5mb3JtYXRpb24sIHBs
ZWFzZSBzZWUgRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9waW5fdXNlcl9wYWdlcy5yc3QuCiAgKgog
ICogQHBhZ2U6CXBvaW50ZXIgdG8gcGFnZSB0byBiZSBxdWVyaWVkLgogICogQFJldHVybjoJVHJ1
ZSwgaWYgaXQgaXMgbGlrZWx5IHRoYXQgdGhlIHBhZ2UgaGFzIGJlZW4gImRtYS1waW5uZWQiLgpA
QCAtMjgzNCw3ICsyODM0LDcgQEAgc3RydWN0IHBhZ2UgKmZvbGxvd19wYWdlKHN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsCiAgKiByZWxlYXNpbmcgcGFn
ZXM6IGdldF91c2VyX3BhZ2VzKigpIHBhZ2VzIG11c3QgYmUgcmVsZWFzZWQgdmlhIHB1dF9wYWdl
KCksCiAgKiB3aGlsZSBwaW5fdXNlcl9wYWdlcyooKSBwYWdlcyBtdXN0IGJlIHJlbGVhc2VkIHZp
YSB1bnBpbl91c2VyX3BhZ2UoKS4KICAqCi0gKiBQbGVhc2Ugc2VlIERvY3VtZW50YXRpb24vdm0v
cGluX3VzZXJfcGFnZXMucnN0IGZvciBtb3JlIGluZm9ybWF0aW9uLgorICogUGxlYXNlIHNlZSBE
b2N1bWVudGF0aW9uL2NvcmUtYXBpL3Bpbl91c2VyX3BhZ2VzLnJzdCBmb3IgbW9yZSBpbmZvcm1h
dGlvbi4KICAqLwogCiBzdGF0aWMgaW5saW5lIGludCB2bV9mYXVsdF90b19lcnJubyh2bV9mYXVs
dF90IHZtX2ZhdWx0LCBpbnQgZm9sbF9mbGFncykKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9s
aW51eC9ldGh0b29sX25ldGxpbmsuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ldGh0b29sX25ldGxp
bmsuaAppbmRleCA3ZmRlNzYzNjZiYTQuLjE3MTFlNTdmNzg0OCAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS91YXBpL2xpbnV4L2V0aHRvb2xfbmV0bGluay5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9l
dGh0b29sX25ldGxpbmsuaApAQCAtMiw3ICsyLDcgQEAKIC8qCiAgKiBpbmNsdWRlL3VhcGkvbGlu
dXgvZXRodG9vbF9uZXRsaW5rLmggLSBuZXRsaW5rIGludGVyZmFjZSBmb3IgZXRodG9vbAogICoK
LSAqIFNlZSBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZXRodG9vbC1uZXRsaW5rLnR4dCBpbiBr
ZXJuZWwgc291cmNlIHRyZWUgZm9yCisgKiBTZWUgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2V0
aHRvb2wtbmV0bGluay5yc3QgaW4ga2VybmVsIHNvdXJjZSB0cmVlIGZvcgogICogZG91Y3VtZW50
YXRpb24gb2YgdGhlIGludGVyZmFjZS4KICAqLwogCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
cmRtYS9yZG1hX3VzZXJfaW9jdGxfY21kcy5oIGIvaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91c2Vy
X2lvY3RsX2NtZHMuaAppbmRleCA3YjFlYzgwNmY4ZjkuLjM4YWI3YWNjYjdiZSAxMDA2NDQKLS0t
IGEvaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91c2VyX2lvY3RsX2NtZHMuaAorKysgYi9pbmNsdWRl
L3VhcGkvcmRtYS9yZG1hX3VzZXJfaW9jdGxfY21kcy5oCkBAIC0zNiw3ICszNiw3IEBACiAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4KICNpbmNsdWRlIDxsaW51eC9pb2N0bC5oPgogCi0vKiBEb2N1
bWVudGF0aW9uL2lvY3RsL2lvY3RsLW51bWJlci5yc3QgKi8KKy8qIERvY3VtZW50YXRpb24vdXNl
cnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0ICovCiAjZGVmaW5lIFJETUFfSU9DVExf
TUFHSUMJMHgxYgogI2RlZmluZSBSRE1BX1ZFUkJTX0lPQ1RMIFwKIAlfSU9XUihSRE1BX0lPQ1RM
X01BR0lDLCAxLCBzdHJ1Y3QgaWJfdXZlcmJzX2lvY3RsX2hkcikKZGlmZiAtLWdpdCBhL21tL2d1
cC5jIGIvbW0vZ3VwLmMKaW5kZXggNjA3NmRmOGUwNGE0Li44MWU0ZDBiMzc3ZmQgMTAwNjQ0Ci0t
LSBhL21tL2d1cC5jCisrKyBiL21tL2d1cC5jCkBAIC0yODQzLDkgKzI4NDMsOSBAQCBFWFBPUlRf
U1lNQk9MX0dQTChnZXRfdXNlcl9wYWdlc19mYXN0KTsKICAqIHRoZSBhcmd1bWVudHMgaGVyZSBh
cmUgaWRlbnRpY2FsLgogICoKICAqIEZPTExfUElOIG1lYW5zIHRoYXQgdGhlIHBhZ2VzIG11c3Qg
YmUgcmVsZWFzZWQgdmlhIHVucGluX3VzZXJfcGFnZSgpLiBQbGVhc2UKLSAqIHNlZSBEb2N1bWVu
dGF0aW9uL3ZtL3Bpbl91c2VyX3BhZ2VzLnJzdCBmb3IgZnVydGhlciBkZXRhaWxzLgorICogc2Vl
IERvY3VtZW50YXRpb24vY29yZS1hcGkvcGluX3VzZXJfcGFnZXMucnN0IGZvciBmdXJ0aGVyIGRl
dGFpbHMuCiAgKgotICogVGhpcyBpcyBpbnRlbmRlZCBmb3IgQ2FzZSAxIChESU8pIGluIERvY3Vt
ZW50YXRpb24vdm0vcGluX3VzZXJfcGFnZXMucnN0LiBJdAorICogVGhpcyBpcyBpbnRlbmRlZCBm
b3IgQ2FzZSAxIChESU8pIGluIERvY3VtZW50YXRpb24vY29yZS1hcGkvcGluX3VzZXJfcGFnZXMu
cnN0LiBJdAogICogaXMgTk9UIGludGVuZGVkIGZvciBDYXNlIDIgKFJETUE6IGxvbmctdGVybSBw
aW5zKS4KICAqLwogaW50IHBpbl91c2VyX3BhZ2VzX2Zhc3QodW5zaWduZWQgbG9uZyBzdGFydCwg
aW50IG5yX3BhZ2VzLApAQCAtMjg4Myw5ICsyODgzLDkgQEAgRVhQT1JUX1NZTUJPTF9HUEwocGlu
X3VzZXJfcGFnZXNfZmFzdCk7CiAgKiB0aGUgYXJndW1lbnRzIGhlcmUgYXJlIGlkZW50aWNhbC4K
ICAqCiAgKiBGT0xMX1BJTiBtZWFucyB0aGF0IHRoZSBwYWdlcyBtdXN0IGJlIHJlbGVhc2VkIHZp
YSB1bnBpbl91c2VyX3BhZ2UoKS4gUGxlYXNlCi0gKiBzZWUgRG9jdW1lbnRhdGlvbi92bS9waW5f
dXNlcl9wYWdlcy5yc3QgZm9yIGRldGFpbHMuCisgKiBzZWUgRG9jdW1lbnRhdGlvbi9jb3JlLWFw
aS9waW5fdXNlcl9wYWdlcy5yc3QgZm9yIGRldGFpbHMuCiAgKgotICogVGhpcyBpcyBpbnRlbmRl
ZCBmb3IgQ2FzZSAxIChESU8pIGluIERvY3VtZW50YXRpb24vdm0vcGluX3VzZXJfcGFnZXMucnN0
LiBJdAorICogVGhpcyBpcyBpbnRlbmRlZCBmb3IgQ2FzZSAxIChESU8pIGluIERvY3VtZW50YXRp
b24vY29yZS1hcGkvcGluX3VzZXJfcGFnZXMucnN0LiBJdAogICogaXMgTk9UIGludGVuZGVkIGZv
ciBDYXNlIDIgKFJETUE6IGxvbmctdGVybSBwaW5zKS4KICAqLwogbG9uZyBwaW5fdXNlcl9wYWdl
c19yZW1vdGUoc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLApA
QCAtMjkxOSw5ICsyOTE5LDkgQEAgRVhQT1JUX1NZTUJPTChwaW5fdXNlcl9wYWdlc19yZW1vdGUp
OwogICogRk9MTF9QSU4gaXMgc2V0LgogICoKICAqIEZPTExfUElOIG1lYW5zIHRoYXQgdGhlIHBh
Z2VzIG11c3QgYmUgcmVsZWFzZWQgdmlhIHVucGluX3VzZXJfcGFnZSgpLiBQbGVhc2UKLSAqIHNl
ZSBEb2N1bWVudGF0aW9uL3ZtL3Bpbl91c2VyX3BhZ2VzLnJzdCBmb3IgZGV0YWlscy4KKyAqIHNl
ZSBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL3Bpbl91c2VyX3BhZ2VzLnJzdCBmb3IgZGV0YWlscy4K
ICAqCi0gKiBUaGlzIGlzIGludGVuZGVkIGZvciBDYXNlIDEgKERJTykgaW4gRG9jdW1lbnRhdGlv
bi92bS9waW5fdXNlcl9wYWdlcy5yc3QuIEl0CisgKiBUaGlzIGlzIGludGVuZGVkIGZvciBDYXNl
IDEgKERJTykgaW4gRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9waW5fdXNlcl9wYWdlcy5yc3QuIEl0
CiAgKiBpcyBOT1QgaW50ZW5kZWQgZm9yIENhc2UgMiAoUkRNQTogbG9uZy10ZXJtIHBpbnMpLgog
ICovCiBsb25nIHBpbl91c2VyX3BhZ2VzKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxv
bmcgbnJfcGFnZXMsCmRpZmYgLS1naXQgYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8tdjMu
YyBiL3ZpcnQva3ZtL2FybS92Z2ljL3ZnaWMtbW1pby12My5jCmluZGV4IGU3MmRjYzQ1NDI0Ny4u
ODU5NDY0ZmQ0MTNmIDEwMDY0NAotLS0gYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8tdjMu
YworKysgYi92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8tdjMuYwpAQCAtMzAxLDcgKzMwMSw3
IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHZnaWNfdjNfdWFjY2Vzc19yZWFkX3BlbmRpbmcoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LAogCSAqIHBlbmRpbmcgc3RhdGUgb2YgaW50ZXJydXB0IGlzIGxh
dGNoZWQgaW4gcGVuZGluZ19sYXRjaCB2YXJpYWJsZS4KIAkgKiBVc2Vyc3BhY2Ugd2lsbCBzYXZl
IGFuZCByZXN0b3JlIHBlbmRpbmcgc3RhdGUgYW5kIGxpbmVfbGV2ZWwKIAkgKiBzZXBhcmF0ZWx5
LgotCSAqIFJlZmVyIHRvIERvY3VtZW50YXRpb24vdmlydC9rdm0vZGV2aWNlcy9hcm0tdmdpYy12
My50eHQKKwkgKiBSZWZlciB0byBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2RldmljZXMvYXJtLXZn
aWMtdjMucnN0CiAJICogZm9yIGhhbmRsaW5nIG9mIElTUEVORFIgYW5kIElDUEVORFIuCiAJICov
CiAJZm9yIChpID0gMDsgaSA8IGxlbiAqIDg7IGkrKykgewpkaWZmIC0tZ2l0IGEvdmlydC9rdm0v
YXJtL3ZnaWMvdmdpYy5oIGIvdmlydC9rdm0vYXJtL3ZnaWMvdmdpYy5oCmluZGV4IDc2OWU0ODAy
NjQ1ZS4uNjRmY2Q3NTExMTEwIDEwMDY0NAotLS0gYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLmgK
KysrIGIvdmlydC9rdm0vYXJtL3ZnaWMvdmdpYy5oCkBAIC00Miw3ICs0Miw3IEBACiAJCQkgICAg
VkdJQ19BRkZJTklUWV9MRVZFTCh2YWwsIDMpKQogCiAvKgotICogQXMgcGVyIERvY3VtZW50YXRp
b24vdmlydC9rdm0vZGV2aWNlcy9hcm0tdmdpYy12My50eHQsCisgKiBBcyBwZXIgRG9jdW1lbnRh
dGlvbi92aXJ0L2t2bS9kZXZpY2VzL2FybS12Z2ljLXYzLnJzdCwKICAqIGJlbG93IG1hY3JvcyBh
cmUgZGVmaW5lZCBmb3IgQ1BVUkVHIGVuY29kaW5nLgogICovCiAjZGVmaW5lIEtWTV9SRUdfQVJN
X1ZHSUNfU1lTUkVHX09QMF9NQVNLICAgMHgwMDAwMDAwMDAwMDBjMDAwCkBAIC02Myw3ICs2Myw3
IEBACiAJCQkJICAgICAgS1ZNX1JFR19BUk1fVkdJQ19TWVNSRUdfT1AyX01BU0spCiAKIC8qCi0g
KiBBcyBwZXIgRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9kZXZpY2VzL2FybS12Z2ljLWl0cy50eHQs
CisgKiBBcyBwZXIgRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9kZXZpY2VzL2FybS12Z2ljLWl0cy5y
c3QsCiAgKiBiZWxvdyBtYWNyb3MgYXJlIGRlZmluZWQgZm9yIElUUyB0YWJsZSBlbnRyeSBlbmNv
ZGluZy4KICAqLwogI2RlZmluZSBLVk1fSVRTX0NURV9WQUxJRF9TSElGVAkJNjMKLS0gCjIuMjUu
MgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJt
IG1haWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMu
Y3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGluZm8va3ZtYXJtCg==

Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD351A3054
	for <lists+kvmarm@lfdr.de>; Thu,  9 Apr 2020 09:39:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DB9D4B17B;
	Thu,  9 Apr 2020 03:39:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpZoduyRYz4A; Thu,  9 Apr 2020 03:39:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E1074B146;
	Thu,  9 Apr 2020 03:39:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F9774B146
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Apr 2020 23:03:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACmFreBKLZpi for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Apr 2020 23:03:15 -0400 (EDT)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A03B94B109
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Apr 2020 23:03:13 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04427; MF=alex.shi@linux.alibaba.com;
 NM=1; PH=DS; RN=50; SR=0; TI=SMTPD_---0Tv02u1U_1586401383; 
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com
 fp:SMTPD_---0Tv02u1U_1586401383) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 09 Apr 2020 11:03:04 +0800
Subject: Re: [PATCH 03/35] docs: fix broken references to text files
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
 <2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
From: Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4a38109b-b764-c2c2-abda-98d357bff6f8@linux.alibaba.com>
Date: Thu, 9 Apr 2020 11:03:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
X-Mailman-Approved-At: Thu, 09 Apr 2020 03:39:36 -0400
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Akira Yokosawa <akiyks@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-unionfs@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 linux-mm@kvack.org, Harry Wei <harryxiyou@gmail.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arch@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
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
 Thomas Zimmermann <tzimmermann@suse.de>, Marc Zyngier <maz@kernel.org>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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

CgrlnKggMjAyMC80Lzgg5LiL5Y2IMTE6NDUsIE1hdXJvIENhcnZhbGhvIENoZWhhYiDlhpnpgZM6
Cj4gIC4uLi90cmFuc2xhdGlvbnMvemhfQ04vZmlsZXN5c3RlbXMvc3lzZnMudHh0ICAgICAgICAg
fCAgMiArLQo+ICAuLi4vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3Mvc3VibWl0LWNoZWNrbGlz
dC5yc3QgIHwgIDIgKy0KCkl0IGxvb2tzIGZpbmUgZm9yIG1lLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBs
aXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1h
bi9saXN0aW5mby9rdm1hcm0K

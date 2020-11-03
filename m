Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D85742A37BD
	for <lists+kvmarm@lfdr.de>; Tue,  3 Nov 2020 01:30:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51FA74B4D9;
	Mon,  2 Nov 2020 19:30:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y5y6I3CqnidT; Mon,  2 Nov 2020 19:30:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 212BF4B347;
	Mon,  2 Nov 2020 19:30:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B54FD4B2AD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 19:30:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1kWT-+sEP-8 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 19:30:22 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E69CF4B2B2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 19:30:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604363422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hx0q/2DUI+smP9x1Al8IAirQNeaRux74kGkZ+Kr9VXc=;
 b=QMbX9rQyah/goAQep/H44V3Trm+haEFDrGzeClA6OZ5TaBjM12/ruQvlJF88JM03CyNbxE
 IilEPpfQRoUgG93C02kDWXfxsAYKPvC8CpRXZ5IMbCv+eqqa3ZWoVG9nsv5vAV1Pz9OHph
 rwCBJqCJp/SjQ7lJ8y7JCWbZ4Iy71o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-4UINqvzFPziXbesVPGcYhw-1; Mon, 02 Nov 2020 19:30:21 -0500
X-MC-Unique: 4UINqvzFPziXbesVPGcYhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEC04809DE5;
 Tue,  3 Nov 2020 00:30:19 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-160.bne.redhat.com [10.64.54.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A0096CE4F;
 Tue,  3 Nov 2020 00:30:12 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Fix build error in user_mem_abort()
Date: Tue,  3 Nov 2020 11:30:09 +1100
Message-Id: <20201103003009.32955-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: will@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 maz@kernel.org
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

VGhlIFBVRCBhbmQgUE1EIGFyZSBmb2xkZWQgaW50byBQR0Qgd2hlbiB0aGUgZm9sbG93aW5nIG9w
dGlvbnMgYXJlCmVuYWJsZWQuIEluIHRoYXQgY2FzZSwgUFVEX1NISUZUIGlzIGVxdWFsIHRvIFBN
RF9TSElGVCBhbmQgd2UgZmFpbAp0byBidWlsZCB3aXRoIHRoZSBpbmRpY2F0ZWQgZXJyb3JzOgoK
ICAgQ09ORklHX0FSTTY0X1ZBX0JJVFNfNDI9eQogICBDT05GSUdfQVJNNjRfUEFHRV9TSElGVD0x
NgogICBDT05GSUdfUEdUQUJMRV9MRVZFTFM9MwoKICAgYXJjaC9hcm02NC9rdm0vbW11LmM6IElu
IGZ1bmN0aW9uIOKAmHVzZXJfbWVtX2Fib3J04oCZOgogICBhcmNoL2FybTY0L2t2bS9tbXUuYzo3
OTg6MjogZXJyb3I6IGR1cGxpY2F0ZSBjYXNlIHZhbHVlCiAgICAgY2FzZSBQTURfU0hJRlQ6CiAg
ICAgXn5+fgogICBhcmNoL2FybTY0L2t2bS9tbXUuYzo3OTE6Mjogbm90ZTogcHJldmlvdXNseSB1
c2VkIGhlcmUKICAgICBjYXNlIFBVRF9TSElGVDoKICAgICBefn5+CgpUaGlzIGZpeGVzIHRoZSBp
c3N1ZSBieSBza2lwcGluZyB0aGUgY2hlY2sgb24gUFVEIGh1Z2UgcGFnZSB3aGVuIFBVRAphbmQg
UE1EIGFyZSBmb2xkZWQgaW50byBQR0QuCgpGaXhlczogMmY0MGM0NjAyMWJiYiAoIktWTTogYXJt
NjQ6IFVzZSBmYWxsYmFjayBtYXBwaW5nIHNpemVzIGZvciBjb250aWd1b3VzIGh1Z2UgcGFnZSBz
aXplcyIpClJlcG9ydGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+ClNp
Z25lZC1vZmYtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+Ci0tLQogYXJjaC9hcm02
NC9rdm0vbW11LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9rdm0vbW11LmMgYi9hcmNoL2FybTY0L2t2bS9tbXUuYwppbmRl
eCA1Nzk3MmJkYjIxM2EuLjFhMDFkYTlmZGM5OSAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rdm0v
bW11LmMKKysrIGIvYXJjaC9hcm02NC9rdm0vbW11LmMKQEAgLTc4OCwxMCArNzg4LDEyIEBAIHN0
YXRpYyBpbnQgdXNlcl9tZW1fYWJvcnQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBwaHlzX2FkZHJf
dCBmYXVsdF9pcGEsCiAJfQogCiAJc3dpdGNoICh2bWFfc2hpZnQpIHsKKyNpZm5kZWYgX19QQUdF
VEFCTEVfUE1EX0ZPTERFRAogCWNhc2UgUFVEX1NISUZUOgogCQlpZiAoZmF1bHRfc3VwcG9ydHNf
c3RhZ2UyX2h1Z2VfbWFwcGluZyhtZW1zbG90LCBodmEsIFBVRF9TSVpFKSkKIAkJCWJyZWFrOwog
CQlmYWxsdGhyb3VnaDsKKyNlbmRpZgogCWNhc2UgQ09OVF9QTURfU0hJRlQ6CiAJCXZtYV9zaGlm
dCA9IFBNRF9TSElGVDsKIAkJZmFsbHRocm91Z2g7Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3Zt
YXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9t
YWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=

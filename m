Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E33BD2A334D
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 19:50:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 433524B57E;
	Mon,  2 Nov 2020 13:50:50 -0500 (EST)
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
	with ESMTP id LABU1PEAsasb; Mon,  2 Nov 2020 13:50:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 153B34B530;
	Mon,  2 Nov 2020 13:50:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BCE6F4B470
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 13:50:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s8AAg7TUcELL for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 13:50:46 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 97E724B36F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 13:50:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604343046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pd92Ipbt2G3Km6tdhbm08U/qeddFNn12kHFL3AbfcrQ=;
 b=fVWwRvlps+mvXaWCjkmRGxRMrNK/pourFak/Ckeey7bn/t6fgFSTmF4pNPJHGwANk/99+t
 mFpsRLH0R0SvLzehkUfJlc6HN1Wxurpw2fnY+6pWfWoj+yXeTYCBTDJ79O4zU6Th4l36OI
 t+TzIYUwjWr56oAvY3l3uVpC3xaLRUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-dY7oM770P_GApuM13bk26Q-1; Mon, 02 Nov 2020 13:50:42 -0500
X-MC-Unique: dY7oM770P_GApuM13bk26Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B5910866A0;
 Mon,  2 Nov 2020 18:50:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD245C629;
 Mon,  2 Nov 2020 18:50:39 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 0/3] KVM: arm64: Fix get-reg-list regression
Date: Mon,  2 Nov 2020 19:50:34 +0100
Message-Id: <20201102185037.49248-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: maz@kernel.org, xu910121@sina.com, Dave.Martin@arm.com
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

5byg5Lic5petIDx4dTkxMDEyMUBzaW5hLmNvbT4gcmVwb3J0ZWQgYSByZWdyZXNzaW9uIHNlZW4g
d2l0aCBDZW50T1MKd2hlbiBtaWdyYXRpbmcgZnJvbSBhbiBvbGQga2VybmVsIHRvIGEgbmV3IG9u
ZS4gVGhlIHByb2JsZW0gd2FzCnRoYXQgUUVNVSByZWplY3RlZCB0aGUgbWlncmF0aW9uIHNpbmNl
IEtWTV9HRVRfUkVHX0xJU1QgcmVwb3J0ZWQKYSByZWdpc3RlciB3YXMgbWlzc2luZyBvbiB0aGUg
ZGVzdGluYXRpb24uIEV4dHJhIHJlZ2lzdGVycyBhcmUgT0sKb24gdGhlIGRlc3RpbmF0aW9uLCBi
dXQgbm90IG1pc3Npbmcgb25lcy4gVGhlIHJlZ3Jlc3Npb24gcmVwcm9kdWNlcwp3aXRoIHVwc3Ry
ZWFtIGtlcm5lbHMgd2hlbiBtaWdyYXRpbmcgZnJvbSBhIDQuMTUgb3IgbGF0ZXIga2VybmVsLAp1
cCB0byBvbmUgd2l0aCBjb21taXQgNzM0MzM3NjJmY2FlICgiS1ZNOiBhcm02NC9zdmU6IFN5c3Rl
bSByZWdpc3Rlcgpjb250ZXh0IHN3aXRjaCBhbmQgYWNjZXNzIHN1cHBvcnQiKSwgdG8gYSBrZXJu
ZWwgdGhhdCBpbmNsdWRlcyB0aGF0CmNvbW1pdCwgZS5nLiB0aGUgbGF0ZXN0IG1haW5saW5lICg1
LjEwLXJjMikuCgpUaGUgZmlyc3QgcGF0Y2ggb2YgdGhpcyBzZXJpZXMgaXMgdGhlIGZpeC4gVGhl
IG5leHQgdHdvIHBhdGNoZXMsCndoaWNoIGRvbid0IGhhdmUgYW55IGludGVuZGVkIGZ1bmN0aW9u
YWwgY2hhbmdlcywgYWxsb3cgSURfU0FOSVRJU0VECnRvIGJlIHVzZWQgZm9yIHJlZ2lzdGVycyB0
aGF0IGZsaXAgYmV0d2VlbiBleHBvc2luZyBmZWF0dXJlcyBhbmQKYmVpbmcgUkFaLCB3aGljaCBh
bGxvd3Mgc29tZSBjb2RlIHRvIGJlIHJlbW92ZWQuCgp2MjoKIC0gQ0Mgc3RhYmxlIFtNYXJjXQog
LSBPbmx5IG9uZSBSQVogZmxhZyBpcyBlbm91Z2ggW01hcmNdCiAtIE1vdmUgaWRfdmlzaWJpbGl0
eSgpIHVwIGJ5IHJlYWRfaWRfcmVnKCkgc2luY2UgdGhleSdsbCBsaWtlbHkKICAgYmUgbWFpbnRh
aW5lZCB0b2dldGhlciBbZHJld10KCkFuZHJldyBKb25lcyAoMyk6CiAgS1ZNOiBhcm02NDogRG9u
J3QgaGlkZSBJRCByZWdpc3RlcnMgZnJvbSB1c2Vyc3BhY2UKICBLVk06IGFybTY0OiBDaGVjayBS
QVogdmlzaWJpbGl0eSBpbiBJRCByZWdpc3RlciBhY2Nlc3NvcnMKICBLVk06IGFybTY0OiBSZW1v
dmUgQUE2NFpGUjBfRUwxIGFjY2Vzc29ycwoKIGFyY2gvYXJtNjQva3ZtL3N5c19yZWdzLmMgfCA5
NiArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGFyY2gvYXJtNjQva3Zt
L3N5c19yZWdzLmggfCAxMCArKysrCiAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyks
IDY5IGRlbGV0aW9ucygtKQoKLS0gCjIuMjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3Mu
Y29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGlu
Zm8va3ZtYXJtCg==

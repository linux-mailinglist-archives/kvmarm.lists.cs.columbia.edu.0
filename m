Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B563A129712
	for <lists+kvmarm@lfdr.de>; Mon, 23 Dec 2019 15:19:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 40F9B4AF5E;
	Mon, 23 Dec 2019 09:19:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3bZ+tWVePu6; Mon, 23 Dec 2019 09:19:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 07EED4AF44;
	Mon, 23 Dec 2019 09:19:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BF8C4AF23
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Dec 2019 09:19:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x2l1Kt5owJ4j for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Dec 2019 09:19:51 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0161E4AF1F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Dec 2019 09:19:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577110790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mL7EP1HVEPCTfjY90+H+xu1r0sHEJd8rLQjw69yZex0=;
 b=e7KyPzIVg3QxvmjJbK2qkkEBkR2A9gRGKhekYI6t8RbToLy3zYCnd8cGmToJM3ScWj9NqZ
 k54FBvM0IDAM6740+FsOuNDR6l8ihQ0XDY/iKQkANXD05IlM7sT915EycarVDso6el8hDF
 XJHzU5XXtjj4IMkhE5w4viguPmXUa98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-KzmNUHtbOzSZH2L4w0OQ9g-1; Mon, 23 Dec 2019 09:19:43 -0500
X-MC-Unique: KzmNUHtbOzSZH2L4w0OQ9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 854A48017DF;
 Mon, 23 Dec 2019 14:19:41 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4687A10375CC;
 Mon, 23 Dec 2019 14:19:35 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
To: Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org
References: <20191220111833.1422-1-yuzenghui@huawei.com>
 <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fd6ec914-0940-a4bd-fc06-f1c211eba5ee@redhat.com>
Date: Mon, 23 Dec 2019 15:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: andre.przywara@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

SGkgWmVuZ2h1aSwKCk9uIDEyLzIzLzE5IDI6NDMgUE0sIFplbmdodWkgWXUgd3JvdGU6Cj4gT24g
MjAxOS8xMi8yMCAxOToxOCwgWmVuZ2h1aSBZdSB3cm90ZToKPj4gQWx0aG91Z2ggZ3Vlc3Qgd2ls
bCBoYXJkbHkgcmVhZCBhbmQgdXNlIHRoZSBQVFogKFBlbmRpbmcgVGFibGUgWmVybykKPj4gYml0
IGluIEdJQ1JfUEVOREJBU0VSLCBsZXQgdXMgZW11bGF0ZSB0aGUgYXJjaGl0ZWN0dXJlIHN0cmlj
dGx5Lgo+PiBBcyBwZXIgSUhJIDAwNjlFIDkuMTEuMzAsIFBUWiBmaWVsZCBpcyBXTywgYW5kIHJl
YWRzIGFzIDAuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFplbmdodWkgWXUgPHl1emVuZ2h1aUBodWF3
ZWkuY29tPgo+PiAtLS0KPj4KPj4gTm90aWNlZCB3aGVuIGNoZWNraW5nIGFsbCBmaWVsZHMgb2Yg
R0lDUl9QRU5EQkFTRVIgcmVnaXN0ZXIuCj4+IEJ1dCBfbm90XyBzdXJlIHdoZXRoZXIgaXQncyB3
b3J0aCBhIGZpeCwgYXMgTGludXggbmV2ZXIgc2V0cwo+PiB0aGUgUFRaIGJpdCBiZWZvcmUgZW5h
YmxpbmcgTFBJIChzZXQgR0lDUl9DVExSX0VOQUJMRV9MUElTKS4KPj4KPj4gQW5kIEkgd29uZGVy
IHVuZGVyIHdoaWNoIHNjZW5hcmlvcyBjYW4gdGhpcyBiaXQgYmUgd3JpdHRlbiBhcyAxLgo+PiBJ
dCBzZWVtcyBkaWZmaWN1bHQgZm9yIHNvZnR3YXJlIHRvIGRldGVybWluZSB3aGV0aGVyIHRoZSBw
ZW5kaW5nCj4+IHRhYmxlIGNvbnRhaW5zIGFsbCB6ZXJvcyB3aGVuIHdyaXRpbmcgdGhpcyBiaXQu
Cj4+Cj4+IMKgIHZpcnQva3ZtL2FybS92Z2ljL3ZnaWMtbW1pby12My5jIHwgNSArKysrLQo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8tdjMuYwo+PiBiL3ZpcnQva3Zt
L2FybS92Z2ljL3ZnaWMtbW1pby12My5jCj4+IGluZGV4IDdkZmQxNWRiYjMwOC4uZWJjMjE4ODQw
ZmMyIDEwMDY0NAo+PiAtLS0gYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8tdjMuYwo+PiAr
KysgYi92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8tdjMuYwo+PiBAQCAtNDE0LDggKzQxNCwx
MSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZwo+PiB2Z2ljX21taW9fcmVhZF9wZW5kYmFzZShzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ3BhX3QgYWRkciwgdW5zaWduZWQgaW50IGxlbikKPj4gwqAgewo+
PiDCoMKgwqDCoMKgIHN0cnVjdCB2Z2ljX2NwdSAqdmdpY19jcHUgPSAmdmNwdS0+YXJjaC52Z2lj
X2NwdTsKPj4gK8KgwqDCoCB1NjQgdmFsdWUgPSB2Z2ljX2NwdS0+cGVuZGJhc2VyOwo+PiDCoCAt
wqDCoMKgIHJldHVybiBleHRyYWN0X2J5dGVzKHZnaWNfY3B1LT5wZW5kYmFzZXIsIGFkZHIgJiA3
LCBsZW4pOwo+PiArwqDCoMKgIHZhbHVlICY9IH5HSUNSX1BFTkRCQVNFUl9QVFo7Cj4+ICsKPj4g
K8KgwqDCoCByZXR1cm4gZXh0cmFjdF9ieXRlcyh2YWx1ZSwgYWRkciAmIDcsIGxlbik7Cj4+IMKg
IH0KPj4gwqAgwqAgc3RhdGljIHZvaWQgdmdpY19tbWlvX3dyaXRlX3BlbmRiYXNlKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwKPj4KPiAKPiBJIG5vdGljZWQgdGhlcmUgaXMgbm8gdXNlcnNwYWNlIGFj
Y2VzcyBjYWxsYmFja3MgZm9yIEdJQ1JfUEVOREJBU0VSLAo+IHNvIHRoaXMgcGF0Y2ggd2lsbCBt
YWtlIHRoZSBQVFogZmllbGQgYWxzbyAnUmVhZCBBcyBaZXJvJyBieSB1c2Vyc3BhY2UuCj4gU2hv
dWxkIHdlIGNvbnNpZGVyIGFkZGluZyBhIHVhY2Nlc3NfcmVhZCBjYWxsYmFjayBmb3IgR0lDUl9Q
RU5EQkFTRVIKPiB3aGljaCBqdXN0IHJldHVybnMgdGhlIHVuY2hhbmdlZCB2Z2ljX2NwdS0+cGVu
ZGJhc2VyIHRvIHVzZXJzcGFjZT8KPiAoVGhvdWdoIHRoaXMgaXMgcmVhbGx5IG5vdCBhIGJpZyBk
ZWFsLiBXZSBub3cgYWx3YXlzIGVtdWxhdGUgdGhlIFBUWgo+IGZpZWxkIHRvIGd1ZXN0IGFzIFJB
Wi4gQW5kICd2Z2ljX2NwdS0+cGVuZGJhc2VyICYgR0lDUl9QRU5EQkFTRVJfUFRaJwo+IG9ubHkg
aW5kaWNhdGVzIHdoZXRoZXIgS1ZNIHdpbGwgb3B0aW1pemUgdGhlIExQSSBlbmFibGluZyBwcm9j
ZXNzLAo+IHdoZXJlIFJlYWQgQXMgWmVybyBpbmRpY2F0ZXMgbmV2ZXIgb3B0aW1pemUuLikKWW91
J3JlIHJpZ2h0LiBJZiB3ZSBzdGFydCBhIG1pZ3JhdGlvbiB3aGVuIHRoZSBQVFogaGFzIGp1c3Qg
YmVlbiBzZXQgYnkKdGhlIFNXLCB0aGVuIHdlIHdpbGwgbWlzcyBpdCBvbiB0aGUgZGVzdGluYXRp
b24gc2lkZS4KClNvIGZvciBpbnN0YW5jZSBpbiB0aGUgbGFzdCBLVk0gdW5pdCB0ZXN0IG9mIG15
IHNlcmllcwooaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtYXJtLzIwMTkxMjE2MTQwMjM1LjEw
NzUxLTE3LWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8pLAppbiB0ZXN0X2l0c19wZW5kaW5nX21pZ3Jh
dGlvbigpLCBpZiB5b3Uga2ljayB0aGUgbWlncmF0aW9uIGJlZm9yZQplbmFibGluZyBMUEkncyBh
dCByZWRpc3QgbGV2ZWwsIHlvdSBzaG91bGRuJ3Qgc2VlIGFueSBMUEkgaGl0dGluZyBvbiB0aGUK
dGFyZ2V0IHdoaWNoIGlzIHRoZW9yZXRpY2FsbHkgd3JvbmcuIFNvIGltcGxlbWVudGluZyBhIHVh
Y2Nlc3NfcmVhZCgpCndvdWxkIGJlIGJldHRlciBJIHRoaW5rLgoKVGhhbmtzCgpFcmljCgorCXB0
ciA9IGdpY3YzX2RhdGEucmVkaXN0X2Jhc2VbbnJfY3B1cyAtIDFdICsgR0lDUl9QRU5EQkFTRVI7
CisJcGVuZGJhc2VyID0gcmVhZHEocHRyKTsKKwl3cml0ZXEocGVuZGJhc2VyICYgfkdJQ1JfUEVO
REJBU0VSX1BUWiwgcHRyKTsKKworCXB0ciA9IGdpY3YzX2RhdGEucmVkaXN0X2Jhc2VbbnJfY3B1
cyAtIDJdICsgR0lDUl9QRU5EQkFTRVI7CisJcGVuZGJhc2VyID0gcmVhZHEocHRyKTsKKwl3cml0
ZXEocGVuZGJhc2VyICYgfkdJQ1JfUEVOREJBU0VSX1BUWiwgcHRyKTsKCisJcHV0cygiTm93IG1p
Z3JhdGUgdGhlIFZNLCB0aGVuIHByZXNzIGEga2V5IHRvIGNvbnRpbnVlLi4uXG4iKTsKKwkodm9p
ZClnZXRjaGFyKCk7CisJcmVwb3J0KHRydWUsICJNaWdyYXRpb24gY29tcGxldGUiKTsKKworCWdp
Y3YzX3JkaXN0X2N0cmxfbHBpKG5yX2NwdXMgLSAxLCB0cnVlKTsKKwlnaWN2M19yZGlzdF9jdHJs
X2xwaShucl9jcHVzIC0gMiwgdHJ1ZSk7CisKPiAKPiAKPiBUaGFua3MsCj4gWmVuZ2h1aQo+IAo+
IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVk
dQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=

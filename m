Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A85F4763
	for <lists+kvmarm@lfdr.de>; Tue,  4 Oct 2022 18:20:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C3084B0E1;
	Tue,  4 Oct 2022 12:20:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eUxTNHfBBivq; Tue,  4 Oct 2022 12:20:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7652749EFA;
	Tue,  4 Oct 2022 12:20:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E3CC249F0F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Oct 2022 12:20:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rC25-gbauUtV for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Oct 2022 12:20:30 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BC1D40C52
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Oct 2022 12:20:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664900430;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIVlQm/eJCK+Dkb+zIV3zL4TzRL4MQMkAUsBE4hUHzo=;
 b=XZs1F6khmqNzeurTA0oY+9YqZZ4wvZgMKNf8gXKLK1lSjeWV9xi2dw1XoFdLVx+XXsZOL0
 /Os+06PKsDY/l08HZuxsQLPn/MAJmZstIkNJvPGeEGrj0RPbMnEIAiCOSmCj5XiMbGrGXt
 w7HenKjbhgjw8a5c5MZRJ/mOj0KoDFQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-ACGx8_wgOX2AU-O2833fOg-1; Tue, 04 Oct 2022 12:20:28 -0400
X-MC-Unique: ACGx8_wgOX2AU-O2833fOg-1
Received: by mail-qk1-f200.google.com with SMTP id
 az15-20020a05620a170f00b006cece4cd0beso12170372qkb.22
 for <kvmarm@lists.cs.columbia.edu>; Tue, 04 Oct 2022 09:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date;
 bh=WIVlQm/eJCK+Dkb+zIV3zL4TzRL4MQMkAUsBE4hUHzo=;
 b=fnbHQ1sAPDCT2lmzmsxk3PACW2aUxy8GpcyaYB2ebZQPF7DRcVb2Dh4UpT3oD+G8gY
 5VlD1JS5rZfJDh38eZQdk5nhME1SeLXqIxdFenrEn7kiTyYi8kUsktF/Ylb8F8saclau
 xanII0QRA6EmJNjOx0ppmhdQFCBI/0WCwtQOQAM9Qi7FQLnO+SKeAK8zIZbAUNhr9QWP
 sla6iNbumZqr7BNdTc/42cU6R+fDGq3aJ++NnADmleSqx6YqiQak0bsZjE0G0m7YU+lA
 7JcQXeYuTZdKpzx0G6ARnDxDorOKUFL+W20jJYYRTWXRD6jhbxQ7pFhWQzUPKUE3/i1d
 d84w==
X-Gm-Message-State: ACrzQf3CR8vv9uZ9QFRL069TNshESSB2CCEy3+WWmxqKj7ug5Z9EOHC/
 fy+UU2p14KJCLvlFDUMq85wF72htCAsuuPImVVrXO4Y+RCIz9mSNikEbgVMWSTprYLiJmH8rrBh
 KHtYBxOFnW/WhuFawQ5ayJ39g
X-Received: by 2002:a05:6214:250c:b0:4b1:a1e7:1d89 with SMTP id
 gf12-20020a056214250c00b004b1a1e71d89mr5522046qvb.1.1664900428098; 
 Tue, 04 Oct 2022 09:20:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7+nPWaq060lSF2LRYxAqI+BNzr2KIZuva9V6DU3zsjrZjyusvZrLO0SYMelN6m2LvYkgbBxA==
X-Received: by 2002:a05:6214:250c:b0:4b1:a1e7:1d89 with SMTP id
 gf12-20020a056214250c00b004b1a1e71d89mr5522019qvb.1.1664900427766; 
 Tue, 04 Oct 2022 09:20:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bx8-20020a05622a090800b0038e24268c29sm381869qtb.79.2022.10.04.09.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Oct 2022 09:20:26 -0700 (PDT)
Message-ID: <89c93f1e-6e78-f679-aecb-7e506fa0cea3@redhat.com>
Date: Tue, 4 Oct 2022 18:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [kvm-unit-tests PATCH v3 0/3] arm: pmu: Fixes for bare metal
To: Ricardo Koller <ricarkol@google.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, andrew.jones@linux.dev
References: <20220805004139.990531-1-ricarkol@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20220805004139.990531-1-ricarkol@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: maz@kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: eric.auger@redhat.com
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

SGkgUmljYXJkbywgTWFyYywKCk9uIDgvNS8yMiAwMjo0MSwgUmljYXJkbyBLb2xsZXIgd3JvdGU6
Cj4gVGhlcmUgYXJlIHNvbWUgdGVzdHMgdGhhdCBmYWlsIHdoZW4gcnVubmluZyBvbiBiYXJlIG1l
dGFsIChpbmNsdWRpbmcgYQo+IHBhc3N0aHJvdWdoIHByb3RvdHlwZSkuICBUaGVyZSBhcmUgdGhy
ZWUgaXNzdWVzIHdpdGggdGhlIHRlc3RzLiAgVGhlCj4gZmlyc3Qgb25lIGlzIHRoYXQgdGhlcmUg
YXJlIHNvbWUgbWlzc2luZyBpc2IoKSdzIGJldHdlZW4gZW5hYmxpbmcgZXZlbnQKPiBjb3VudGlu
ZyBhbmQgdGhlIGFjdHVhbCBjb3VudGluZy4gVGhpcyB3YXNuJ3QgYW4gaXNzdWUgb24gS1ZNIGFz
Cj4gdHJhcHBpbmcgb24gcmVnaXN0ZXJzIHNlcnZlZCBhcyBjb250ZXh0IHN5bmNocm9uaXphdGlv
biBldmVudHMuIFRoZQo+IHNlY29uZCBpc3N1ZSBpcyB0aGF0IHNvbWUgdGVzdHMgYXNzdW1lIHRo
YXQgcmVnaXN0ZXJzIHJlc2V0IHRvIDAuICBBbmQKPiBmaW5hbGx5LCB0aGUgdGhpcmQgaXNzdWUg
aXMgdGhhdCBvdmVyZmxvd2luZyB0aGUgbG93IGNvdW50ZXIgb2YgYQo+IGNoYWluZWQgZXZlbnQg
c2V0cyB0aGUgb3ZlcmZsb3cgZmxhZyBpbiBQTVZPUyBhbmQgc29tZSB0ZXN0cyBmYWlsIGJ5Cj4g
Y2hlY2tpbmcgZm9yIGl0IG5vdCBiZWluZyBzZXQuCj4KPiBBZGRyZXNzZWQgYWxsIGNvbW1lbnRz
IGZyb20gdGhlIHByZXZpb3VzIHZlcnNpb246Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3Zt
YXJtLzIwMjIwODAzMTgyMzI4LjI0Mzg1OTgtMS1yaWNhcmtvbEBnb29nbGUuY29tL1QvI3QKPiAt
IGFkZGluZyBtaXNzaW5nIGlzYigpIGFuZCBmaXhlZCB0aGUgY29tbWl0IG1lc3NhZ2UgKEFsZXhh
bmRydSkuCj4gLSBmaXhlZCB3b3JkaW5nIG9mIGEgcmVwb3J0KCkgY2hlY2sgKEFuZHJldykuCj4K
PiBUaGFua3MhCj4gUmljYXJkbwo+Cj4gUmljYXJkbyBLb2xsZXIgKDMpOgo+ICAgYXJtOiBwbXU6
IEFkZCBtaXNzaW5nIGlzYigpJ3MgYWZ0ZXIgc3lzIHJlZ2lzdGVyIHdyaXRpbmcKPiAgIGFybTog
cG11OiBSZXNldCB0aGUgcG11IHJlZ2lzdGVycyBiZWZvcmUgc3RhcnRpbmcgc29tZSB0ZXN0cwo+
ICAgYXJtOiBwbXU6IENoZWNrIGZvciBvdmVyZmxvdyBpbiB0aGUgbG93IGNvdW50ZXIgaW4gY2hh
aW5lZCBjb3VudGVycwo+ICAgICB0ZXN0cwo+Cj4gIGFybS9wbXUuYyB8IDU2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNo
YW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQo+CldoaWxlIHRlc3Rpbmcg
dGhpcyBzZXJpZXMgYW5kIHRoZSByZWxhdGVkICdbUEFUQ0ggMC85XSBLVk06IGFybTY0OiBQTVU6
CkZpeGluZyBjaGFpbmVkIGV2ZW50cywgYW5kIFBNVXYzcDUgc3VwcG9ydCcgSSBub3RpY2VkIEkg
aGF2ZSBrdm0gdW5pdAp0ZXN0IGZhaWx1cmVzIG9uIHNvbWUgbWFjaGluZXMuIFRoaXMgZG9lcyBu
b3Qgc2VlbSByZWxhdGVkIHRvIHRob3NlCnNlcmllcyB0aG91Z2ggc2luY2UgSSB3YXMgYWJsZSB0
byBnZXQgdGhlbSB3aXRob3V0LiBUaGUgZmFpbHVyZXMgaGFwcGVuCm9uIEFtYmVyd2luZyBtYWNo
aW5lIGZvciBpbnN0YW5jZSB3aXRoIHRoZSBwbXUtY2hhaW4tcHJvbW90aW9uLgoKV2hpbGUgZnVy
dGhlciBpbnZlc3RpZ2F0aW5nIEkgbm90aWNlZCB0aGVyZSBpcyBhIGxvdCBvZiB2YXJpYWJpbGl0
eSBvbgp0aGUga3ZtIHVuaXQgdGVzdCBtZW1fYWNjZXNzX2xvb3AoKSBjb3VudC4gSSBjYW4gZ2V0
IHRoZSBjb3VudGVyID0gMHgxRgpvbiB0aGUgZmlyc3QgaXRlcmF0aW9uIGFuZCAweDk2IG9uIHRo
ZSBzdWJzZXF1ZW50IG9uZXMgZm9yIGluc3RhbmNlLgpXaGlsZSBydW5uaW5nIG1lbV9hY2Nlc3Nf
bG9vcChhZGRyLCAyMCwgcG11LnBtY3Jfcm8gfCBQTVVfUE1DUl9FKSBJIHdhcwpleHBlY3Rpbmcg
dGhlIGNvdW50ZXIgdG8gYmUgY2xvc2UgdG8gMjAuIEl0IGlzIG9uIHNvbWUgSFcuCgrCoMKgwqDC
oMKgwqDCoCBmb3IgKGludCBpID0gMDsgaSA8IDIwOyBpKyspIHsKwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHdyaXRlX3JlZ25fZWwwKHBtZXZ0eXBlciwgMCwgTUVNX0FDQ0VTUyB8ClBN
RVZUWVBFUl9FWENMVURFX0VMMCk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0
ZV9zeXNyZWdfcygweDEsIFBNQ05URU5TRVRfRUwwKTsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHdyaXRlX3JlZ25fZWwwKHBtZXZjbnRyLCAwLCAwKTsKwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlzYigpOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtX2Fj
Y2Vzc19sb29wKGFkZHIsIDIwLCBwbXUucG1jcl9ybyB8IFBNVV9QTUNSX0UpOwrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaXNiKCk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXBvcnRfaW5mbygiaXRlciAlZCwgTUVNX0FDQ0VTUyBjb3VudGVyICMwIGhhcyB2YWx1ZQow
eCVseCIsCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpLCByZWFkX3JlZ25fZWwwKHBtZXZjbnRyLCAwKSk7CsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB3cml0ZV9zeXNyZWdfcygweDAsIFBNQ05URU5DTFJfRUwwKTsKwqDCoMKgwqDC
oMKgwqAgfQoKW0kga25vdyB0aGVyZSBhcmUgc29tZSB1c2VsZXNzIGlzYidzIGJ5IHRoZSB3YXkg
YnV0IHRoYXQncyBqdXN0IGRlYnVnIGNvZGUuXQoKZ2l2ZXMKCklORk86IFBNVSB2ZXJzaW9uOiAw
eDEKSU5GTzogUE1VIGltcGxlbWVudGVyL0lEIGNvZGU6IDB4NTEoIlEiKS8wCklORk86IEltcGxl
bWVudHMgOCBldmVudCBjb3VudGVycwpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0
ZXIgMCwgTUVNX0FDQ0VTUyBjb3VudGVyICMwIGhhcyB2YWx1ZQoweDFmCklORk86IHBtdTogcG11
LWNoYWluLXByb21vdGlvbjogaXRlciAxLCBNRU1fQUNDRVNTIGNvdW50ZXIgIzAgaGFzIHZhbHVl
CjB4OTYgPC0tLSA/CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAyLCBNRU1f
QUNDRVNTIGNvdW50ZXIgIzAgaGFzIHZhbHVlIDB4OTYKSU5GTzogcG11OiBwbXUtY2hhaW4tcHJv
bW90aW9uOiBpdGVyIDMsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUgMHg5NgpJTkZP
OiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgNCwgTUVNX0FDQ0VTUyBjb3VudGVyICMw
IGhhcyB2YWx1ZSAweDk2CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciA1LCBN
RU1fQUNDRVNTIGNvdW50ZXIgIzAgaGFzIHZhbHVlIDB4OTYKSU5GTzogcG11OiBwbXUtY2hhaW4t
cHJvbW90aW9uOiBpdGVyIDYsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUgMHg5NgpJ
TkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgNywgTUVNX0FDQ0VTUyBjb3VudGVy
ICMwIGhhcyB2YWx1ZSAweDk2CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciA4
LCBNRU1fQUNDRVNTIGNvdW50ZXIgIzAgaGFzIHZhbHVlIDB4OTYKSU5GTzogcG11OiBwbXUtY2hh
aW4tcHJvbW90aW9uOiBpdGVyIDksIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUgMHg5
NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTAsIE1FTV9BQ0NFU1MgY291
bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0
ZXIgMTEsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBt
dS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTIsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFs
dWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTMsIE1FTV9BQ0NF
U1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rp
b246IGl0ZXIgMTQsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBw
bXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTUsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBo
YXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTYsIE1F
TV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1w
cm9tb3Rpb246IGl0ZXIgMTcsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJ
TkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTgsIE1FTV9BQ0NFU1MgY291bnRl
ciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIg
MTksIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgoKSWYgSSBydW4gdGhlIGZv
bGxvd2luZyBzZXF1ZW5jZSBiZWZvcmUgdGhlIHByZXZpb3VzIG9uZToKwqDCoMKgwqDCoMKgwqAg
Zm9yIChpbnQgaSA9IDA7IGkgPCAyMDsgaSsrKSB7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB3cml0ZV9yZWduX2VsMChwbWV2dHlwZXIsIDAsIFNXX0lOQ1IgfApQTUVWVFlQRVJfRVhD
TFVERV9FTDApOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVfc3lzcmVnX3Mo
MHgxLCBQTUNOVEVOU0VUX0VMMCk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0
ZV9yZWduX2VsMChwbWV2Y250ciwgMCwgMCk7CgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2V0X3BtY3IocG11LnBtY3Jfcm8gfCBQTVVfUE1DUl9FKTsKwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZvciAoaW50IGogPSAwOyBqIDwgMjA7IGorKykKwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0ZV9zeXNyZWcoMHgxLCBwbXN3aW5j
X2VsMCk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXRfcG1jcihwbXUucG1jcl9y
byk7CgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVwb3J0X2luZm8oIml0ZXIgJWQs
IDIwIHggU1dfSU5DUnMgY291bnRlciAjMCBoYXMgdmFsdWUKMHglbHgiLArCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaSwgcmVhZF9yZWduX2Vs
MChwbWV2Y250ciwgMCkpOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVfc3lz
cmVnX3MoMHgwLCBQTUNOVEVOQ0xSX0VMMCk7CsKgwqDCoMKgwqDCoMKgIH0KCkkgZ2V0CgpJTkZP
OiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMCwgMjAgeCBTV19JTkNScyBjb3VudGVy
ICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAx
LCAyMCB4IFNXX0lOQ1JzIGNvdW50ZXIgIzAgaGFzCnZhbHVlIDB4MTQKSU5GTzogcG11OiBwbXUt
Y2hhaW4tcHJvbW90aW9uOiBpdGVyIDIsIDIwIHggU1dfSU5DUnMgY291bnRlciAjMCBoYXMKdmFs
dWUgMHgxNApJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMywgMjAgeCBTV19J
TkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21v
dGlvbjogaXRlciA0LCAyMCB4IFNXX0lOQ1JzIGNvdW50ZXIgIzAgaGFzCnZhbHVlIDB4MTQKSU5G
TzogcG11OiBwbXUtY2hhaW4tcHJvbW90aW9uOiBpdGVyIDUsIDIwIHggU1dfSU5DUnMgY291bnRl
ciAjMCBoYXMKdmFsdWUgMHgxNApJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIg
NiwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11
LWNoYWluLXByb21vdGlvbjogaXRlciA3LCAyMCB4IFNXX0lOQ1JzIGNvdW50ZXIgIzAgaGFzCnZh
bHVlIDB4MTQKSU5GTzogcG11OiBwbXUtY2hhaW4tcHJvbW90aW9uOiBpdGVyIDgsIDIwIHggU1df
SU5DUnMgY291bnRlciAjMCBoYXMKdmFsdWUgMHgxNApJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9t
b3Rpb246IGl0ZXIgOSwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklO
Rk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAxMCwgMjAgeCBTV19JTkNScyBjb3Vu
dGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRl
ciAxMSwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTog
cG11LWNoYWluLXByb21vdGlvbjogaXRlciAxMiwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhh
cwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAxMywgMjAg
eCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWlu
LXByb21vdGlvbjogaXRlciAxNCwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAw
eDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAxNSwgMjAgeCBTV19JTkNS
cyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlv
bjogaXRlciAxNiwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86
IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAxNywgMjAgeCBTV19JTkNScyBjb3VudGVy
ICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAx
OCwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2YWx1ZSAweDE0CklORk86IHBtdTogcG11
LWNoYWluLXByb21vdGlvbjogaXRlciAxOSwgMjAgeCBTV19JTkNScyBjb3VudGVyICMwIGhhcwp2
YWx1ZSAweDE0CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAwLCBNRU1fQUND
RVNTIGNvdW50ZXIgIzAgaGFzIHZhbHVlCjB4OTYgPC0tLQpJTkZPOiBwbXU6IHBtdS1jaGFpbi1w
cm9tb3Rpb246IGl0ZXIgMSwgTUVNX0FDQ0VTUyBjb3VudGVyICMwIGhhcyB2YWx1ZSAweDk2CklO
Rk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciAyLCBNRU1fQUNDRVNTIGNvdW50ZXIg
IzAgaGFzIHZhbHVlIDB4OTYKSU5GTzogcG11OiBwbXUtY2hhaW4tcHJvbW90aW9uOiBpdGVyIDMs
IE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUgMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFp
bi1wcm9tb3Rpb246IGl0ZXIgNCwgTUVNX0FDQ0VTUyBjb3VudGVyICMwIGhhcyB2YWx1ZSAweDk2
CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciA1LCBNRU1fQUNDRVNTIGNvdW50
ZXIgIzAgaGFzIHZhbHVlIDB4OTYKSU5GTzogcG11OiBwbXUtY2hhaW4tcHJvbW90aW9uOiBpdGVy
IDYsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUgMHg5NgpJTkZPOiBwbXU6IHBtdS1j
aGFpbi1wcm9tb3Rpb246IGl0ZXIgNywgTUVNX0FDQ0VTUyBjb3VudGVyICMwIGhhcyB2YWx1ZSAw
eDk2CklORk86IHBtdTogcG11LWNoYWluLXByb21vdGlvbjogaXRlciA4LCBNRU1fQUNDRVNTIGNv
dW50ZXIgIzAgaGFzIHZhbHVlIDB4OTYKSU5GTzogcG11OiBwbXUtY2hhaW4tcHJvbW90aW9uOiBp
dGVyIDksIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUgMHg5NgpJTkZPOiBwbXU6IHBt
dS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTAsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFs
dWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTEsIE1FTV9BQ0NF
U1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rp
b246IGl0ZXIgMTIsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBw
bXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTMsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBo
YXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTQsIE1F
TV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1w
cm9tb3Rpb246IGl0ZXIgMTUsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJ
TkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTYsIE1FTV9BQ0NFU1MgY291bnRl
ciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIg
MTcsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgpJTkZPOiBwbXU6IHBtdS1j
aGFpbi1wcm9tb3Rpb246IGl0ZXIgMTgsIE1FTV9BQ0NFU1MgY291bnRlciAjMCBoYXMgdmFsdWUK
MHg5NgpJTkZPOiBwbXU6IHBtdS1jaGFpbi1wcm9tb3Rpb246IGl0ZXIgMTksIE1FTV9BQ0NFU1Mg
Y291bnRlciAjMCBoYXMgdmFsdWUKMHg5NgoKU28gSSBjb21lIHRvIHRoZSBhY3R1YWwgcXVlc3Rp
b24uIENhbiB3ZSBkbyBhbnkgYXNzdW1wdGlvbiBvbiB0aGUKKHZpcnR1YWwpIFBNVSBxdWFsaXR5
L3ByZWNpc2lvbj8gSWYgbm90LCB0aGUgdGVzdHMgSSBvcmlnaW5hbGx5IHdyb3RlCmFyZSBkYW1u
ZWQgdG8gZmFpbCBvbiBzb21lIEhXIChvbiBzb21lIG90aGVyIHRoZXkgYWx3YXlzIHBhc3MpIGFu
ZCBJCm5lZWQgdG8gbWFrZSBhIGRlY2lzaW9uIHdydCByZS13cml0aW5nIHBhcnQgb2YgdGhlbSwg
ZXhwZWNpYWxseSB0aG9zZQp3aGljaCBleHBlY3Qgb3ZlcmZsb3cgYWZ0ZXIgYSBnaXZlbiBhbW91
bnQgb2Ygb3BzLiBPdGhlcndpc2UsIHRoZXJlIGlzCmVpdGhlciBzb21ldGhpbmcgd3JvbmcgaW4g
dGhlIHRlc3QgKGFzbT8pIG9yIGluIEtWTSBQTVUgZW11bGF0aW9uLgoKSSB0cmllZCB0byBiaXNl
Y3QgYmVjYXVzZSBJIGRpZCBvYnNlcnZlIHRoZSBzYW1lIGJlaGF2aW9yIG9uIHNvbWUgb2xkZXIK
a2VybmVscyBidXQgdGhlIGJpc2VjdCB3YXMgbm90IHN1Y2Nlc3NmdWwgYXMgdGhlIGlzc3VlIGRv
ZXMgbm90IGhhcHBlbgphbHdheXMuCgpUaG91Z2h0cz8KCkVyaWMKCgoKCgoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0
Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5l
ZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K

Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 982D332A8A0
	for <lists+kvmarm@lfdr.de>; Tue,  2 Mar 2021 18:56:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 30A024B5D7;
	Tue,  2 Mar 2021 12:56:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIv2opm8vgMg; Tue,  2 Mar 2021 12:56:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 907C34B6BA;
	Tue,  2 Mar 2021 12:56:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A8224B5D7
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 12:56:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 39ehsKFXDE5U for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Mar 2021 12:56:47 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9080C4B5CB
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 12:56:47 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E946F31B;
 Tue,  2 Mar 2021 09:56:46 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9E923F766;
 Tue,  2 Mar 2021 09:56:45 -0800 (PST)
Subject: Re: [PATCH kvmtool v2 00/22] Unify I/O port and MMIO trap handling
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20210225005915.26423-1-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <fabb6032-6ac2-f418-c5e6-12cd7b4cbdc5@arm.com>
Date: Tue, 2 Mar 2021 17:57:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210225005915.26423-1-andre.przywara@arm.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, Sami Mujawar <sami.mujawar@arm.com>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

SGkgQW5kcmUsCgpJJ3ZlIHN0YXJ0ZWQgdG8gcmV2aWV3IHRoaXMgaXRlcmF0aW9uIGFuZCBJJ3Zl
IGNvbWUgYWNyb3NzIHRoaXMgZXJyb3Igd2hlbiB0cnlpbmcKdG8gYXBwbHkgdGhlIHBhdGNoZXM6
CgokIGdpdCBhbSAtLXJlamVjdApwYXRjaGVzL3VuaWZ5LWlvcG9ydC1hbmQtbW1pby92Mi9Vbmlm
eS1JLU8tcG9ydC1hbmQtTU1JTy10cmFwLWhhbmRsaW5nLnBhdGNoCkFwcGx5aW5nOiBpb3BvcnQ6
IFJlbW92ZSBpb3BvcnRfX3NldHVwX2FyY2goKQpDaGVja2luZyBwYXRjaCBhcm0vaW9wb3J0LmMu
Li4KQ2hlY2tpbmcgcGF0Y2ggaW5jbHVkZS9rdm0vaW9wb3J0LmguLi4KQ2hlY2tpbmcgcGF0Y2gg
aW9wb3J0LmMuLi4KQ2hlY2tpbmcgcGF0Y2ggbWlwcy9rdm0uYy4uLgpDaGVja2luZyBwYXRjaCBw
b3dlcnBjL2lvcG9ydC5jLi4uCkNoZWNraW5nIHBhdGNoIHg4Ni9pb3BvcnQuYy4uLgpBcHBsaWVk
IHBhdGNoIGFybS9pb3BvcnQuYyBjbGVhbmx5LgpBcHBsaWVkIHBhdGNoIGluY2x1ZGUva3ZtL2lv
cG9ydC5oIGNsZWFubHkuCkFwcGxpZWQgcGF0Y2ggaW9wb3J0LmMgY2xlYW5seS4KQXBwbGllZCBw
YXRjaCBtaXBzL2t2bS5jIGNsZWFubHkuCkFwcGxpZWQgcGF0Y2ggcG93ZXJwYy9pb3BvcnQuYyBj
bGVhbmx5LgpBcHBsaWVkIHBhdGNoIHg4Ni9pb3BvcnQuYyBjbGVhbmx5LgpBcHBseWluZzogaHcv
c2VyaWFsOiBVc2UgZGV2aWNlIGFic3RyYWN0aW9uIGZvciBGRFQgZ2VuZXJhdG9yIGZ1bmN0aW9u
CkNoZWNraW5nIHBhdGNoIGh3L3NlcmlhbC5jLi4uCkNoZWNraW5nIHBhdGNoIGluY2x1ZGUva3Zt
L2t2bS5oLi4uCkFwcGxpZWQgcGF0Y2ggaHcvc2VyaWFsLmMgY2xlYW5seS4KQXBwbGllZCBwYXRj
aCBpbmNsdWRlL2t2bS9rdm0uaCBjbGVhbmx5LgpBcHBseWluZzogaW9wb3J0OiBSZXRpcmUgLmdl
bmVyYXRlX2ZkdF9ub2RlIGZ1bmN0aW9uYWxpdHkKQ2hlY2tpbmcgcGF0Y2ggaW5jbHVkZS9rdm0v
aW9wb3J0LmguLi4KQ2hlY2tpbmcgcGF0Y2ggaW9wb3J0LmMuLi4KQXBwbGllZCBwYXRjaCBpbmNs
dWRlL2t2bS9pb3BvcnQuaCBjbGVhbmx5LgpBcHBsaWVkIHBhdGNoIGlvcG9ydC5jIGNsZWFubHku
CkFwcGx5aW5nOiBtbWlvOiBFeHRlbmQgaGFuZGxpbmcgdG8gaW5jbHVkZSBpb3BvcnQgZW11bGF0
aW9uCkNoZWNraW5nIHBhdGNoIGluY2x1ZGUva3ZtL2t2bS5oLi4uCkNoZWNraW5nIHBhdGNoIGlv
cG9ydC5jLi4uCkNoZWNraW5nIHBhdGNoIG1taW8uYy4uLgpBcHBsaWVkIHBhdGNoIGluY2x1ZGUv
a3ZtL2t2bS5oIGNsZWFubHkuCkFwcGxpZWQgcGF0Y2ggaW9wb3J0LmMgY2xlYW5seS4KQXBwbGll
ZCBwYXRjaCBtbWlvLmMgY2xlYW5seS4KQXBwbHlpbmc6IGh3L2k4MDQyOiBDbGVhbiB1cCBkYXRh
IHR5cGVzCkNoZWNraW5nIHBhdGNoIGh3L2k4MDQyLmMuLi4KQXBwbGllZCBwYXRjaCBody9pODA0
Mi5jIGNsZWFubHkuCkFwcGx5aW5nOiBody9pODA0MjogUmVmYWN0b3IgdHJhcCBoYW5kbGVyCkNo
ZWNraW5nIHBhdGNoIGh3L2k4MDQyLmMuLi4KQXBwbGllZCBwYXRjaCBody9pODA0Mi5jIGNsZWFu
bHkuCkFwcGx5aW5nOiBody9pODA0MjogU3dpdGNoIHRvIG5ldyB0cmFwIGhhbmRsZXJzCkNoZWNr
aW5nIHBhdGNoIGh3L2k4MDQyLmMuLi4KZXJyb3I6IHdoaWxlIHNlYXJjaGluZyBmb3I6CsKgwqDC
oCDCoMKgwqAgaW9wb3J0X193cml0ZTgoZGF0YSwgdmFsdWUpOwp9CgovKgrCoCogQ2FsbGVkIHdo
ZW4gdGhlIE9TIGhhcyB3cml0dGVuIHRvIG9uZSBvZiB0aGUga2V5Ym9hcmQncyBwb3J0cyAoMHg2
MCBvciAweDY0KQrCoCovCnN0YXRpYyBib29sIGtiZF9pbihzdHJ1Y3QgaW9wb3J0ICppb3BvcnQs
IHN0cnVjdCBrdm1fY3B1ICp2Y3B1LCB1MTYgcG9ydCwgdm9pZAoqZGF0YSwgaW50IHNpemUpCnsK
wqDCoMKgIGtiZF9pbyh2Y3B1LCBwb3J0LCBkYXRhLCBzaXplLCBmYWxzZSwgTlVMTCk7CgrCoMKg
wqAgcmV0dXJuIHRydWU7Cn0KCnN0YXRpYyBib29sIGtiZF9vdXQoc3RydWN0IGlvcG9ydCAqaW9w
b3J0LCBzdHJ1Y3Qga3ZtX2NwdSAqdmNwdSwgdTE2IHBvcnQsIHZvaWQKKmRhdGEsIGludCBzaXpl
KQp7CsKgwqDCoCBrYmRfaW8odmNwdSwgcG9ydCwgZGF0YSwgc2l6ZSwgdHJ1ZSwgTlVMTCk7CgrC
oMKgwqAgcmV0dXJuIHRydWU7Cn0KCnN0YXRpYyBzdHJ1Y3QgaW9wb3J0X29wZXJhdGlvbnMga2Jk
X29wcyA9IHsKwqDCoMKgIC5pb19pbsKgwqDCoCDCoMKgwqAgPSBrYmRfaW4sCsKgwqDCoCAuaW9f
b3V0wqDCoMKgIMKgwqDCoCA9IGtiZF9vdXQsCn07CgppbnQga2JkX19pbml0KHN0cnVjdCBrdm0g
Kmt2bSkKewrCoMKgwqAgaW50IHI7CgrCoMKgwqAga2JkX3Jlc2V0KCk7CsKgwqDCoCBzdGF0ZS5r
dm0gPSBrdm07CsKgwqDCoCByID0gaW9wb3J0X19yZWdpc3Rlcihrdm0sIEk4MDQyX0RBVEFfUkVH
LCAma2JkX29wcywgMiwgTlVMTCk7CsKgwqDCoCBpZiAociA8IDApCsKgwqDCoCDCoMKgwqAgcmV0
dXJuIHI7CsKgwqDCoCByID0gaW9wb3J0X19yZWdpc3Rlcihrdm0sIEk4MDQyX0NPTU1BTkRfUkVH
LCAma2JkX29wcywgMiwgTlVMTCk7CsKgwqDCoCBpZiAociA8IDApIHsKwqDCoMKgIMKgwqDCoCBp
b3BvcnRfX3VucmVnaXN0ZXIoa3ZtLCBJODA0Ml9EQVRBX1JFRyk7CsKgwqDCoCDCoMKgwqAgcmV0
dXJuIHI7CsKgwqDCoCB9CgoKZXJyb3I6IHBhdGNoIGZhaWxlZDogaHcvaTgwNDIuYzozMjUKQ2hl
Y2tpbmcgcGF0Y2ggaW5jbHVkZS9rdm0vaTgwNDIuaC4uLgpBcHBseWluZyBwYXRjaCBody9pODA0
Mi5jIHdpdGggMSByZWplY3QuLi4KUmVqZWN0ZWQgaHVuayAjMS4KQXBwbGllZCBwYXRjaCBpbmNs
dWRlL2t2bS9pODA0Mi5oIGNsZWFubHkuClBhdGNoIGZhaWxlZCBhdCAwMDA3IGh3L2k4MDQyOiBT
d2l0Y2ggdG8gbmV3IHRyYXAgaGFuZGxlcnMKaGludDogVXNlICdnaXQgYW0gLS1zaG93LWN1cnJl
bnQtcGF0Y2g9ZGlmZicgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gKV2hlbiB5b3UgaGF2ZSByZXNv
bHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29udGludWUiLgpJZiB5b3UgcHJlZmVy
IHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0gLS1za2lwIiBpbnN0ZWFkLgpUbyByZXN0
b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0Y2hpbmcsIHJ1biAiZ2l0IGFtIC0t
YWJvcnQiLgoKd2hlcmUgdGhlIHBhdGNoIGZpbGUgaXMgZnJvbSBwYXRjaHdvcmsua2VybmVsLm9y
ZyBbMV0sIGNyZWF0ZWQgd2hlbiBjbGlja2luZyBvbgp0aGUgInNlcmllcyIgYnV0dG9uIG9uIHRo
ZSB0b3AgcmlnaHQuIEknbSBub3Qgc3VyZSB3aGF0IGlzIGNhdXNpbmcgdGhlIGVycm9yLApldmVy
eXRoaW5nIGxvb2tzIHRoZSBzYW1lIHRvIG1lLgoKUmVnYXJkbGVzcywgSSd2ZSBhcHBsaWVkIHRo
ZSByZWplY3QgbWFudWFsbHkgYW5kIGV2ZXJ5dGhpbmcgbG9va3Mgb2suCgpbMV0KaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2t2bS9wYXRjaC8yMDIxMDIyNTAwNTkxNS4yNjQy
My0yLWFuZHJlLnByenl3YXJhQGFybS5jb20vCgpUaGFua3MsCgpBbGV4CgpPbiAyLzI1LzIxIDEy
OjU4IEFNLCBBbmRyZSBQcnp5d2FyYSB3cm90ZToKPiBDb21wYXJlZCB0byB2MSB0aGlzIGhhcyBh
IGZldyBmaXhlcywgYXMgc3VnZ2VzdGVkIGJ5IEFsZXguCj4gVGhlcmUgaXMgYSBuZXcgcGF0Y2gg
MjAvMjIsIHdoaWNoIGNsZWFucyB1cCB0aGUgQVJNIG1lbW9yeSBtYXAKPiBkZWZpbml0aW9uIGFu
ZCBhZGRzIHNvbWUgY2hhcnQgdG8gbWFrZSBpdCBtb3JlIG9idmlvdXMgd2hhdCBpcyBnb2luZyBv
bi4KPiBGb3IgYSBjaGFuZ2Vsb2csIHNlZSBiZWxvdy4KPgo+ID09PT09PT09PT09PT09Cj4KPiBB
dCB0aGUgbW9tZW50IHdlIHVzZSB0d28gc2VwYXJhdGUgY29kZSBwYXRocyB0byBoYW5kbGUgZXhp
dHMgZm9yCj4gS1ZNX0VYSVRfSU8gKGlvcG9ydC5jKSBhbmQgS1ZNX0VYSVRfTU1JTyAobW1pby5j
KSwgZXZlbiB0aG91Z2ggdGhleQo+IGFyZSBzZW1hbnRpY2FsbHkgdmVyeSBzaW1pbGFyLiBCZWNh
dXNlIHRoZSB0cmFwIGhhbmRsZXIgY2FsbGJhY2sgcm91dGluZQo+IGlzIGRpZmZlcmVudCwgZGV2
aWNlcyBuZWVkIHRvIGRlY2lkZSBvbiBvbmUgY29uZHVpdCBvciBuZWVkIHRvIHByb3ZpZGUKPiBk
aWZmZXJlbnQgaGFuZGxlciBmdW5jdGlvbnMgZm9yIGJvdGggb2YgdGhlbS4KPgo+IFRoaXMgaXMg
bm90IG9ubHkgdW5uZWNlc3NhcnkgY29kZSBkdXBsaWNhdGlvbiwgYnV0IG1ha2VzIHN3aXRjaGlu
Zwo+IGRldmljZXMgZnJvbSBJL08gcG9ydCB0byBNTUlPIGEgdGVkaW91cyB0YXNrLCBldmVuIHRo
b3VnaCB0aGVyZSBpcyBubwo+IHJlYWwgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSB0d28sIGVzcGVj
aWFsbHkgb24gQVJNIGFuZCBQb3dlclBDLgo+Cj4gRm9yIEFSTSB3ZSBhaW0gYXQgcHJvdmlkaW5n
IGEgZmxleGlibGUgbWVtb3J5IGxheW91dCwgYW5kIGFsc28gaGF2ZQo+IHRyb3VibGUgd2l0aCB0
aGUgVUFSVCBhbmQgUlRDIGRldmljZSBvdmVybGFwcGluZyB3aXRoIHRoZSBQQ0kgSS9PIGFyZWEs
Cj4gc28gaXQgc2VlbXMgaW5kaWNhdGVkIHRvIHRhY2tsZSB0aGlzIG9uY2UgYW5kIGZvciBhbGwu
Cj4KPiBUaGUgZmlyc3QgdGhyZWUgcGF0Y2hlcyBkbyBzb21lIGNsZWFudXAsIHRvIHNpbXBsaWZ5
IHRoaW5ncyBsYXRlci4KPgo+IFBhdGNoIDA0LzIyIGxheXMgdGhlIGdyb3VuZHdvcmssIGJ5IGV4
dGVuZGluZyBtbWlvLmMgdG8gYmUgYWJsZSB0byBhbHNvCj4gcmVnaXN0ZXIgSS9PIHBvcnQgdHJh
cCBoYW5kbGVycywgdXNpbmcgdGhlIHNhbWUgY2FsbGJhY2sgcHJvdG90eXBlIGFzCj4gd2UgdXNl
IGZvciBNTUlPLgo+Cj4gVGhlIG5leHQgMTQgcGF0Y2hlcyB0aGVuIGNvbnZlcnQgZGV2aWNlcyB0
aGF0IHVzZSB0aGUgSS9PIHBvcnQKPiBpbnRlcmZhY2Ugb3ZlciB0byB0aGUgbmV3IGpvaW50IGlu
dGVyZmFjZS4gVGhpcyByZXF1aXJlcyB0byByZXdvcmsKPiB0aGUgdHJhcCBoYW5kbGVyIHJvdXRp
bmUgdG8gYWRoZXJlIHRvIHRoZSBzYW1lIHByb3RvdHlwZSBhcyB0aGUgZXhpc3RpbmcKPiBNTUlP
IGhhbmRsZXJzLiBGb3IgbW9zdCBkZXZpY2VzIHRoaXMgaXMgZG9uZSBpbiB0d28gc3RlcHM6IGEg
Zmlyc3QgdG8KPiBpbnRyb2R1Y2UgdGhlIHJld29ya2VkIGhhbmRsZXIgcm91dGluZSwgYW5kIGEg
c2Vjb25kIHRvIHN3aXRjaCB0byB0aGUgbmV3Cj4gam9pbnQgcmVnaXN0cmF0aW9uIHJvdXRpbmUu
IEZvciBzb21lIGRldmljZXMgdGhlIGZpcnN0IHN0ZXAgaXMgdHJpdmlhbCwKPiBzbyBpdCdzIGRv
bmUgaW4gb25lIHBhdGNoLgo+Cj4gUGF0Y2ggMTkvMjIgdGhlbiByZXRpcmVzIHRoZSBvbGQgSS9P
IHBvcnQgaW50ZXJmYWNlLCBieSByZW1vdmluZyBpb3BvcnQuYwo+IGFuZCBmcmllbmRzLgo+IFBh
dGNoIDIwLzIyIHVzZXMgdGhlIG9wcG9ydHVuaXR5IHRvIGNsZWFuIHVwIHRoZSBtZW1vcnkgbWFw
IGRlc2NyaXB0aW9uLAo+IGFsc28gZGVjbGFyZXMgYSBuZXcgcmVnaW9uIChmcm9tIDE2TUIgb24p
LCB3aGVyZSB0aGUgZmluYWwgdHdvIHBhdGNoZXMKPiBzd2l0Y2ggdGhlIFVBUlQgYW5kIHRoZSBS
VEMgZGV2aWNlIHRvLiBUaGV5IGFyZSBub3cgcmVnaXN0ZXJlZAo+IG9uIHRoZSBNTUlPICJidXMi
LCB3aGVuIHJ1bm5pbmcgb24gQVJNIG9yIGFybTY0LiBUaGlzIG1vdmVzIHRoZW0gYXdheQo+IGZy
b20gdGhlIGZpcnN0IDY0S0IsIHNvIHRoZXkgYXJlIG5vdCBpbiB0aGUgUENJIEkvTyBhcmVhIGFu
eW1vcmUuCj4KPiBQbGVhc2UgaGF2ZSBhIGxvb2sgYW5kIGNvbW1lbnQhCj4KPiBDaGVlcnMsCj4g
QW5kcmUKPgo+IENoYW5nZWxvZyB2MSAuLiB2MjoKPiAtIHJld29yayBtZW1vcnkgbWFwIGRlZmlu
aXRpb24KPiAtIGFkZCBleHBsaWNpdCBkZWJ1ZyBvdXRwdXQgZm9yIGRlYnVnIEkvTyBwb3J0Cj4g
LSBhZGQgZXhwbGljaXQgY2hlY2sgZm9yIE1NSU8gY29hbGVzY2luZyBvbiBJL08gcG9ydHMKPiAt
IGRyb3AgdXNhZ2Ugb2YgaW9wb3J0X197cmVhZCx3cml0ZX04KCkgZnJvbSBzZXJpYWwKPiAtIGRy
b3AgZXhwbGljaXQgSS9PIHBvcnQgY2xlYW51cCByb3V0aW5lICh0byBtaW1pYyBNTUlPIG9wZXJh
dGlvbikKPiAtIGFkZCBjb21tZW50IGZvciBJT1RSQVBfQlVTX01BU0sKPiAtIG1pbm9yIGNsZWFu
dXBzIC8gZm9ybWF0dGluZyBjaGFuZ2VzCj4KPiBBbmRyZSBQcnp5d2FyYSAoMjIpOgo+ICAgaW9w
b3J0OiBSZW1vdmUgaW9wb3J0X19zZXR1cF9hcmNoKCkKPiAgIGh3L3NlcmlhbDogVXNlIGRldmlj
ZSBhYnN0cmFjdGlvbiBmb3IgRkRUIGdlbmVyYXRvciBmdW5jdGlvbgo+ICAgaW9wb3J0OiBSZXRp
cmUgLmdlbmVyYXRlX2ZkdF9ub2RlIGZ1bmN0aW9uYWxpdHkKPiAgIG1taW86IEV4dGVuZCBoYW5k
bGluZyB0byBpbmNsdWRlIGlvcG9ydCBlbXVsYXRpb24KPiAgIGh3L2k4MDQyOiBDbGVhbiB1cCBk
YXRhIHR5cGVzCj4gICBody9pODA0MjogUmVmYWN0b3IgdHJhcCBoYW5kbGVyCj4gICBody9pODA0
MjogU3dpdGNoIHRvIG5ldyB0cmFwIGhhbmRsZXJzCj4gICB4ODYvaW9wb3J0OiBSZWZhY3RvciB0
cmFwIGhhbmRsZXJzCj4gICB4ODYvaW9wb3J0OiBTd2l0Y2ggdG8gbmV3IHRyYXAgaGFuZGxlcnMK
PiAgIGh3L3J0YzogUmVmYWN0b3IgdHJhcCBoYW5kbGVycwo+ICAgaHcvcnRjOiBTd2l0Y2ggdG8g
bmV3IHRyYXAgaGFuZGxlcgo+ICAgaHcvdmVzYTogU3dpdGNoIHRyYXAgaGFuZGxpbmcgdG8gdXNl
IE1NSU8gaGFuZGxlcgo+ICAgaHcvc2VyaWFsOiBSZWZhY3RvciB0cmFwIGhhbmRsZXIKPiAgIGh3
L3NlcmlhbDogU3dpdGNoIHRvIG5ldyB0cmFwIGhhbmRsZXJzCj4gICB2ZmlvOiBSZWZhY3RvciBp
b3BvcnQgdHJhcCBoYW5kbGVyCj4gICB2ZmlvOiBTd2l0Y2ggdG8gbmV3IGlvcG9ydCB0cmFwIGhh
bmRsZXJzCj4gICB2aXJ0aW86IFN3aXRjaCB0cmFwIGhhbmRsaW5nIHRvIHVzZSBNTUlPIGhhbmRs
ZXIKPiAgIHBjaTogU3dpdGNoIHRyYXAgaGFuZGxpbmcgdG8gdXNlIE1NSU8gaGFuZGxlcgo+ICAg
UmVtb3ZlIGlvcG9ydCBzcGVjaWZpYyByb3V0aW5lcwo+ICAgYXJtOiBSZW9yZ2FuaXNlIGFuZCBk
b2N1bWVudCBtZW1vcnkgbWFwCj4gICBody9zZXJpYWw6IEFSTS9hcm02NDogVXNlIE1NSU8gYXQg
aGlnaGVyIGFkZHJlc3Nlcwo+ICAgaHcvcnRjOiBBUk0vYXJtNjQ6IFVzZSBNTUlPIGF0IGhpZ2hl
ciBhZGRyZXNzZXMKPgo+ICBNYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
LQo+ICBhcm0vaW5jbHVkZS9hcm0tY29tbW9uL2t2bS1hcmNoLmggfCAgNDcgKysrKy0tCj4gIGFy
bS9pb3BvcnQuYyAgICAgICAgICAgICAgICAgICAgICB8ICAgNSAtCj4gIGh3L2k4MDQyLmMgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA5NCArKysrKy0tLS0tLS0KPiAgaHcvcnRjLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDkxICsrKysrKy0tLS0tLQo+ICBody9zZXJpYWwuYyAgICAg
ICAgICAgICAgICAgICAgICAgfCAxNjAgKysrKysrKysrKysrLS0tLS0tLS0KPiAgaHcvdmVzYS5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE5ICstLQo+ICBpbmNsdWRlL2t2bS9pODA0Mi5o
ICAgICAgICAgICAgICAgfCAgIDEgLQo+ICBpbmNsdWRlL2t2bS9pb3BvcnQuaCAgICAgICAgICAg
ICAgfCAgMzIgLS0tLQo+ICBpbmNsdWRlL2t2bS9rdm0uaCAgICAgICAgICAgICAgICAgfCAgNDkg
KysrKysrLQo+ICBpb3BvcnQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMzUgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIG1pcHMva3ZtLmMgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgNSAtCj4gIG1taW8uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2NSAr
KysrKysrLS0KPiAgcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDgyICsrKy0t
LS0tLS0tCj4gIHBvd2VycGMvaW9wb3J0LmMgICAgICAgICAgICAgICAgICB8ICAgNiAtCj4gIHZm
aW8vY29yZS5jICAgICAgICAgICAgICAgICAgICAgICB8ICA1MCArKysrLS0tCj4gIHZpcnRpby9w
Y2kuYyAgICAgICAgICAgICAgICAgICAgICB8ICA0NiArKy0tLS0KPiAgeDg2L2lvcG9ydC5jICAg
ICAgICAgICAgICAgICAgICAgIHwgMTA3ICsrKysrKystLS0tLS0tCj4gIDE4IGZpbGVzIGNoYW5n
ZWQsIDQzMyBpbnNlcnRpb25zKCspLCA2NjIgZGVsZXRpb25zKC0pCj4gIGRlbGV0ZSBtb2RlIDEw
MDY0NCBpb3BvcnQuYwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpo
dHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=

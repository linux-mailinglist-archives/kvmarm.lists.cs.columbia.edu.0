Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4D628280
	for <lists+kvmarm@lfdr.de>; Mon, 14 Nov 2022 15:29:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B6E64BB2A;
	Mon, 14 Nov 2022 09:29:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@samsung.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ivFLptB+c3pe; Mon, 14 Nov 2022 09:29:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63D444BB20;
	Mon, 14 Nov 2022 09:29:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A7F04BA1C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Nov 2022 09:29:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWdlRydUSvzG for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Nov 2022 09:29:17 -0500 (EST)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E6CEA4BA03
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Nov 2022 09:29:16 -0500 (EST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20221114142915euoutp02bbd5459402655f09bf41bbc93bd4b115~nedgI9a6d1018510185euoutp02_
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Nov 2022 14:29:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20221114142915euoutp02bbd5459402655f09bf41bbc93bd4b115~nedgI9a6d1018510185euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1668436155;
 bh=tH7IvdpIRni8xd8mM+dKwkwd+lFrflP2wBRHEgT3wJc=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=BrzQkGfeLACul2lUmFt9c4BJ7/IxGcp/unQxzgG207NLWpgGKGfYGz3CTQ/6VNrAn
 j+P5rXoPpQKodlYfFgDOq0FxgfyGRqghIu3wSuxAg50FQFuFAfGC2rR2MTK2egW3CX
 i9avjRJDcwXPWvlkEXrMvQ2GJXTRQZxBxWVyJH4c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20221114142915eucas1p19dbfd418578d2c55d92133788422a21b~nedf3wAAz2164621646eucas1p1q;
 Mon, 14 Nov 2022 14:29:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.B3.09561.BB052736; Mon, 14
 Nov 2022 14:29:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20221114142915eucas1p258f3ca2c536bde712c068e96851468fd~nedffZu6s1272912729eucas1p2d;
 Mon, 14 Nov 2022 14:29:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20221114142915eusmtrp2eb2cd8603adfc2795efcc4618842ba77~nedfeZvH42331123311eusmtrp2W;
 Mon, 14 Nov 2022 14:29:15 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-b2-637250bbe67a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.6A.08916.AB052736; Mon, 14
 Nov 2022 14:29:14 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20221114142914eusmtip150f1cfb9b1e92f0c95d56aa3760fc365~nedepCj391861518615eusmtip1i;
 Mon, 14 Nov 2022 14:29:14 +0000 (GMT)
Message-ID: <d9854277-0411-8169-9e8b-68d15e4c0248@samsung.com>
Date: Mon, 14 Nov 2022 15:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v5 08/14] KVM: arm64: Protect stage-2 traversal with RCU
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221107215644.1895162-9-oliver.upton@linux.dev>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djP87q7A4qSDW7NFLeYvvIym8WyC/IW
 kxubWSxe7trGZHF/33ImizlTCy0+njrObvFqy2EWi02Pr7Fa7JxzktVi6s83bBZb9n9jtziz
 aRuLxd6GGWwWe9c8Z7E4ev4Wk0XLHVMHQY8189YweizYVOqxaVUnm8fChqnMHuc3rWH22Lyk
 3uPF5pmMHu/3XWXz+LxJLoAzissmJTUnsyy1SN8ugSvj5vdbjAV91hX3eyexNzCuM+hi5OSQ
 EDCReNSygK2LkYtDSGAFo8Ta+9OZIJwvjBJTf7SwQDifGSWOdn9lg2n5OP8DK0RiOaPEhWON
 zCAJIYGPjBK/PgiD2LwCdhI9B/+DxVkEVCUunp/EAhEXlDg58wmYLSqQIrFwyw0mEFtYwEei
 /9YfMJtZQFzi1pP5YGeICMxhlLg68QnYNmaBncwSjzr6wKrYBAwlut52gZ3ECbTtxtKFrBDd
 8hLNW2czgzRICBzmlPj8ZgLU3S4SF3bcY4ewhSVeHd8CZctI/N8JsU5CoJ1RYsHv+1DOBEaJ
 hue3GCGqrCXunPsFNIkDaIWmxPpd+hBhR4mJP6exgIQlBPgkbrwVhDiCT2LStunMEGFeiY42
 IYhqNYlZx9fBrT144RLzBEalWUgBMwspAGYheWcWwt4FjCyrGMVTS4tz01OLDfNSy/WKE3OL
 S/PS9ZLzczcxAlPh6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK882Tyk4V4UxIrq1KL8uOLSnNS
 iw8xSnOwKInzss3QShYSSE8sSc1OTS1ILYLJMnFwSjUw9XkWhoWIL69oNuOSkTe8HPSnrfHp
 Qk5OBc5dd7/X/xJwO8YgudaRabuG/445IU/Tlc0ZXfdZmQf0nwxve+b6hC9ewqn/01Xpj+4T
 s5ivLQ/9tI3zjkFmhdqt6+6srELXFW14rsfcn3r20r+53/9ptCyatCKD9W2z47YXRX8d1v/d
 vz32tPAf07u3mKPnWeauX3IhaW7apoLpD01XLywuW5Fi3+W2r4TlpubOnsXrBOWPGWzJm/Zx
 zdT6DV+3rCp9bXapVqi94fKOF1ua5b2VFeNm3vnFqCRz//kRzT3BF17feMK17OqflIjAm3ss
 fSacTnd4aTDVr1mEMfSEfFLxmvKl6Tafnl/S2uucE1SooMRSnJFoqMVcVJwIAMbVT2n0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7q7AoqSDVYdM7eYvvIym8WyC/IW
 kxubWSxe7trGZHF/33ImizlTCy0+njrObvFqy2EWi02Pr7Fa7JxzktVi6s83bBZb9n9jtziz
 aRuLxd6GGWwWe9c8Z7E4ev4Wk0XLHVMHQY8189YweizYVOqxaVUnm8fChqnMHuc3rWH22Lyk
 3uPF5pmMHu/3XWXz+LxJLoAzSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ
 384mJTUnsyy1SN8uQS/j5vdbjAV91hX3eyexNzCuM+hi5OSQEDCR+Dj/A2sXIxeHkMBSRonT
 s+YzQyRkJE5Oa2CFsIUl/lzrYoMoes8oMXfiC0aQBK+AnUTPwf9gDSwCqhIXz09igYgLSpyc
 +QTI5uAQFUiRWHckCiQsLOAj0X/rDxOIzSwgLnHryXwmkJkiAnMYJTbfmskI4jAL7GSW2HTi
 NTtIlZBAocTuu6vBFrAJGEp0vQW5gpODE2jxjaULWSEmmUl0be1ihLDlJZq3zmaewCg0C8kd
 s5AsnIWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI3/bsZ+bdzDOe/VR7xAj
 EwfjIUYJDmYlEd55MvnJQrwpiZVVqUX58UWlOanFhxhNgYExkVlKNDkfmHrySuINzQxMDU3M
 LA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYYi+dXblJyi09uyFtTn5uEItr5R23
 jLnF+eyJ/7Kny1w/95lP+kDW117Opp3P111I5rvpn7XW037iT0urnw45n1ctM989eepu5hm8
 N/mkqi1PMlbKvlvYKcYmIsBzbVWV1NmoaasCVvjO4XedFCbi93RNjlJJHk/At3c3k33e7Hu3
 LP3gLW7TG475vAtq7Yx2nem5zPxE6PGvRuk7c07lXjsreFG8PL3vOY/OsV89JhnyyQfaexQV
 /S7IOKsmsZ/zE72izal/8Pmn3i4tq7f7w1uXMGmWr7ylto7b89i1WzK3Xpqs/+jQ4Wj2t07A
 4sy/PVVlAkt2yZw4ULKH1T7uetbLSTfuGX4T3uX1pyRCiaU4I9FQi7moOBEAdwTikYUDAAA=
X-CMS-MailID: 20221114142915eucas1p258f3ca2c536bde712c068e96851468fd
X-Msg-Generator: CA
X-RootMTR: 20221114142915eucas1p258f3ca2c536bde712c068e96851468fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221114142915eucas1p258f3ca2c536bde712c068e96851468fd
References: <20221107215644.1895162-1-oliver.upton@linux.dev>
 <20221107215644.1895162-9-oliver.upton@linux.dev>
 <CGME20221114142915eucas1p258f3ca2c536bde712c068e96851468fd@eucas1p2.samsung.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

SGkgT2xpdmVyLAoKT24gMDcuMTEuMjAyMiAyMjo1NiwgT2xpdmVyIFVwdG9uIHdyb3RlOgo+IFVz
ZSBSQ1UgdG8gc2FmZWx5IHdhbGsgdGhlIHN0YWdlLTIgcGFnZSB0YWJsZXMgaW4gcGFyYWxsZWwu
IEFjcXVpcmUgYW5kCj4gcmVsZWFzZSB0aGUgUkNVIHJlYWQgbG9jayB3aGVuIHRyYXZlcnNpbmcg
dGhlIHBhZ2UgdGFibGVzLiBEZWZlciB0aGUKPiBmcmVlaW5nIG9mIHRhYmxlIG1lbW9yeSB0byBh
biBSQ1UgY2FsbGJhY2suIEluZGlyZWN0IHRoZSBjYWxscyBpbnRvIFJDVQo+IGFuZCBwcm92aWRl
IHN0dWJzIGZvciBoeXBlcnZpc29yIGNvZGUsIGFzIFJDVSBpcyBub3QgYXZhaWxhYmxlIGluIHN1
Y2ggYQo+IGNvbnRleHQuCj4KPiBUaGUgUkNVIHByb3RlY3Rpb24gZG9lc24ndCBhbW91bnQgdG8g
bXVjaCBhdCB0aGUgbW9tZW50LCBhcyByZWFkZXJzIGFyZQo+IGFscmVhZHkgcHJvdGVjdGVkIGJ5
IHRoZSByZWFkLXdyaXRlIGxvY2sgKGFsbCB3YWxrZXJzIHRoYXQgZnJlZSB0YWJsZQo+IG1lbW9y
eSB0YWtlIHRoZSB3cml0ZSBsb2NrKS4gTm9uZXRoZWxlc3MsIGEgc3Vic2VxdWVudCBjaGFuZ2Ug
d2lsbAo+IGZ1dGhlciByZWxheCB0aGUgbG9ja2luZyByZXF1aXJlbWVudHMgYXJvdW5kIHRoZSBz
dGFnZS0yIE1NVSwgdGhlcmVieQo+IGRlcGVuZGluZyBvbiBSQ1UuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBPbGl2ZXIgVXB0b24gPG9saXZlci51cHRvbkBsaW51eC5kZXY+CgpUaGlzIHBhdGNoIGxhbmRl
ZCBpbiB0b2RheSdzIGxpbnV4LW5leHQgKDIwMjIxMTE0KSBhcyBjb21taXQgCmMzMTE5YWU0NWRm
YiAoIktWTTogYXJtNjQ6IFByb3RlY3Qgc3RhZ2UtMiB0cmF2ZXJzYWwgd2l0aCBSQ1UiKS4gClVu
Zm9ydHVuYXRlbHkgaXQgaW50cm9kdWNlcyBhIGZvbGxvd2luZyB3YXJuaW5nOgoKLS0tPjgtLS0K
Cmt2bSBbMV06IElQQSBTaXplIExpbWl0OiA0MCBiaXRzCkJVRzogc2xlZXBpbmcgZnVuY3Rpb24g
Y2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0IGF0IAppbmNsdWRlL2xpbnV4L3NjaGVkL21tLmg6
Mjc0CmluX2F0b21pYygpOiAwLCBpcnFzX2Rpc2FibGVkKCk6IDAsIG5vbl9ibG9jazogMCwgcGlk
OiAxLCBuYW1lOiBzd2FwcGVyLzAKcHJlZW1wdF9jb3VudDogMCwgZXhwZWN0ZWQ6IDAKUkNVIG5l
c3QgZGVwdGg6IDEsIGV4cGVjdGVkOiAwCjIgbG9ja3MgaGVsZCBieSBzd2FwcGVyLzAvMToKIMKg
IzA6IGZmZmY4MDAwMGE4YTQ0ZDAgKGt2bV9oeXBfcGdkX211dGV4KXsrLisufS17MzozfSwgYXQ6
IApfX2NyZWF0ZV9oeXBfbWFwcGluZ3MrMHg4MC8weGM0CiDCoCMxOiBmZmZmODAwMDBhOTI3NzIw
IChyY3VfcmVhZF9sb2NrKXsuLi4ufS17MToyfSwgYXQ6IAprdm1fcGd0YWJsZV93YWxrKzB4MC8w
eDFmNApDUFU6IDIgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjEuMC1yYzMr
ICM1OTE4CkhhcmR3YXJlIG5hbWU6IFJhc3BiZXJyeSBQaSAzIE1vZGVsIEIgKERUKQpDYWxsIHRy
YWNlOgogwqBkdW1wX2JhY2t0cmFjZS5wYXJ0LjArMHhlNC8weGYwCiDCoHNob3dfc3RhY2srMHgx
OC8weDQwCiDCoGR1bXBfc3RhY2tfbHZsKzB4OGMvMHhiOAogwqBkdW1wX3N0YWNrKzB4MTgvMHgz
NAogwqBfX21pZ2h0X3Jlc2NoZWQrMHgxNzgvMHgyMjAKIMKgX19taWdodF9zbGVlcCsweDQ4LzB4
YTAKIMKgcHJlcGFyZV9hbGxvY19wYWdlcysweDE3OC8weDFhMAogwqBfX2FsbG9jX3BhZ2VzKzB4
OWMvMHgxMDljCiDCoGFsbG9jX3BhZ2VfaW50ZXJsZWF2ZSsweDFjLzB4YzQKIMKgYWxsb2NfcGFn
ZXMrMHhlYy8weDE2MAogwqBnZXRfemVyb2VkX3BhZ2UrMHgxYy8weDQ0CiDCoGt2bV9oeXBfemFs
bG9jX3BhZ2UrMHgxNC8weDIwCiDCoGh5cF9tYXBfd2Fsa2VyKzB4ZDQvMHgxMzQKIMKga3ZtX3Bn
dGFibGVfdmlzaXRvcl9jYi5pc3JhLjArMHgzOC8weDVjCiDCoF9fa3ZtX3BndGFibGVfd2Fsaysw
eDFhNC8weDIyMAogwqBrdm1fcGd0YWJsZV93YWxrKzB4MTA0LzB4MWY0CiDCoGt2bV9wZ3RhYmxl
X2h5cF9tYXArMHg4MC8weGM0CiDCoF9fY3JlYXRlX2h5cF9tYXBwaW5ncysweDljLzB4YzQKIMKg
a3ZtX21tdV9pbml0KzB4MTQ0LzB4MWNjCiDCoGt2bV9hcmNoX2luaXQrMHhlNC8weGVmNAogwqBr
dm1faW5pdCsweDNjLzB4M2QwCiDCoGFybV9pbml0KzB4MjAvMHgzMAogwqBkb19vbmVfaW5pdGNh
bGwrMHg3NC8weDQwMAogwqBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDJlMC8weDM1MAogwqBrZXJu
ZWxfaW5pdCsweDI0LzB4MTMwCiDCoHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwCmt2bSBbMV06IEh5
cCBtb2RlIGluaXRpYWxpemVkIHN1Y2Nlc3NmdWxseQoKLS0tPjgtLS0tCgpJIGxvb2tzIHRoYXQg
bW9yZSBjaGFuZ2VzIGluIHRoZSBLVk0gY29kZSBhcmUgbmVlZGVkIHRvIHVzZSBSQ1UgZm9yIHRo
YXQgCmNvZGUuCgo+IC0tLQo+ICAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1fcGd0YWJsZS5o
IHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgYXJjaC9hcm02NC9rdm0vaHlw
L3BndGFibGUuYyAgICAgICAgIHwgMTAgKysrKystCj4gICBhcmNoL2FybTY0L2t2bS9tbXUuYyAg
ICAgICAgICAgICAgICAgfCAxNCArKysrKysrLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5j
bHVkZS9hc20va3ZtX3BndGFibGUuaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX3BndGFi
bGUuaAo+IGluZGV4IGU3MGNmNTdiNzE5ZS4uNzYzNGI2OTY0Nzc5IDEwMDY0NAo+IC0tLSBhL2Fy
Y2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX3BndGFibGUuaAo+ICsrKyBiL2FyY2gvYXJtNjQvaW5j
bHVkZS9hc20va3ZtX3BndGFibGUuaAo+IEBAIC0zNyw2ICszNywxMyBAQCBzdGF0aWMgaW5saW5l
IHU2NCBrdm1fZ2V0X3BhcmFuZ2UodTY0IG1tZnIwKQo+ICAgCj4gICB0eXBlZGVmIHU2NCBrdm1f
cHRlX3Q7Cj4gICAKPiArLyoKPiArICogUkNVIGNhbm5vdCBiZSB1c2VkIGluIGEgbm9uLWtlcm5l
bCBjb250ZXh0IHN1Y2ggYXMgdGhlIGh5cC4gQXMgc3VjaCwgcGFnZQo+ICsgKiB0YWJsZSB3YWxr
ZXJzIHVzZWQgaW4gaHlwIGRvIG5vdCBjYWxsIGludG8gUkNVIGFuZCBpbnN0ZWFkIHVzZSBvdGhl
cgo+ICsgKiBzeW5jaHJvbml6YXRpb24gbWVjaGFuaXNtcyAoc3VjaCBhcyBhIHNwaW5sb2NrKS4K
PiArICovCj4gKyNpZiBkZWZpbmVkKF9fS1ZNX05WSEVfSFlQRVJWSVNPUl9fKSB8fCBkZWZpbmVk
KF9fS1ZNX1ZIRV9IWVBFUlZJU09SX18pCj4gKwo+ICAgdHlwZWRlZiBrdm1fcHRlX3QgKmt2bV9w
dGVyZWZfdDsKPiAgIAo+ICAgc3RhdGljIGlubGluZSBrdm1fcHRlX3QgKmt2bV9kZXJlZmVyZW5j
ZV9wdGVyZWYoa3ZtX3B0ZXJlZl90IHB0ZXJlZiwgYm9vbCBzaGFyZWQpCj4gQEAgLTQ0LDYgKzUx
LDQwIEBAIHN0YXRpYyBpbmxpbmUga3ZtX3B0ZV90ICprdm1fZGVyZWZlcmVuY2VfcHRlcmVmKGt2
bV9wdGVyZWZfdCBwdGVyZWYsIGJvb2wgc2hhcmVkCj4gICAJcmV0dXJuIHB0ZXJlZjsKPiAgIH0K
PiAgIAo+ICtzdGF0aWMgaW5saW5lIHZvaWQga3ZtX3BndGFibGVfd2Fsa19iZWdpbih2b2lkKSB7
fQo+ICtzdGF0aWMgaW5saW5lIHZvaWQga3ZtX3BndGFibGVfd2Fsa19lbmQodm9pZCkge30KPiAr
Cj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBrdm1fcGd0YWJsZV93YWxrX2xvY2tfaGVsZCh2b2lkKQo+
ICt7Cj4gKwlyZXR1cm4gdHJ1ZTsKPiArfQo+ICsKPiArI2Vsc2UKPiArCj4gK3R5cGVkZWYga3Zt
X3B0ZV90IF9fcmN1ICprdm1fcHRlcmVmX3Q7Cj4gKwo+ICtzdGF0aWMgaW5saW5lIGt2bV9wdGVf
dCAqa3ZtX2RlcmVmZXJlbmNlX3B0ZXJlZihrdm1fcHRlcmVmX3QgcHRlcmVmLCBib29sIHNoYXJl
ZCkKPiArewo+ICsJcmV0dXJuIHJjdV9kZXJlZmVyZW5jZV9jaGVjayhwdGVyZWYsICFzaGFyZWQp
Owo+ICt9Cj4gKwo+ICtzdGF0aWMgaW5saW5lIHZvaWQga3ZtX3BndGFibGVfd2Fsa19iZWdpbih2
b2lkKQo+ICt7Cj4gKwlyY3VfcmVhZF9sb2NrKCk7Cj4gK30KPiArCj4gK3N0YXRpYyBpbmxpbmUg
dm9pZCBrdm1fcGd0YWJsZV93YWxrX2VuZCh2b2lkKQo+ICt7Cj4gKwlyY3VfcmVhZF91bmxvY2so
KTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSBib29sIGt2bV9wZ3RhYmxlX3dhbGtfbG9ja19o
ZWxkKHZvaWQpCj4gK3sKPiArCXJldHVybiByY3VfcmVhZF9sb2NrX2hlbGQoKTsKPiArfQo+ICsK
PiArI2VuZGlmCj4gKwo+ICAgI2RlZmluZSBLVk1fUFRFX1ZBTElECQkJQklUKDApCj4gICAKPiAg
ICNkZWZpbmUgS1ZNX1BURV9BRERSX01BU0sJCUdFTk1BU0soNDcsIFBBR0VfU0hJRlQpCj4gQEAg
LTIwMiwxMSArMjQzLDE0IEBAIHN0cnVjdCBrdm1fcGd0YWJsZSB7Cj4gICAgKgkJCQkJY2hpbGRy
ZW4uCj4gICAgKiBAS1ZNX1BHVEFCTEVfV0FMS19UQUJMRV9QT1NUOglWaXNpdCB0YWJsZSBlbnRy
aWVzIGFmdGVyIHRoZWlyCj4gICAgKgkJCQkJY2hpbGRyZW4uCj4gKyAqIEBLVk1fUEdUQUJMRV9X
QUxLX1NIQVJFRDoJCUluZGljYXRlcyB0aGUgcGFnZS10YWJsZXMgbWF5IGJlIHNoYXJlZAo+ICsg
KgkJCQkJd2l0aCBvdGhlciBzb2Z0d2FyZSB3YWxrZXJzLgo+ICAgICovCj4gICBlbnVtIGt2bV9w
Z3RhYmxlX3dhbGtfZmxhZ3Mgewo+ICAgCUtWTV9QR1RBQkxFX1dBTEtfTEVBRgkJCT0gQklUKDAp
LAo+ICAgCUtWTV9QR1RBQkxFX1dBTEtfVEFCTEVfUFJFCQk9IEJJVCgxKSwKPiAgIAlLVk1fUEdU
QUJMRV9XQUxLX1RBQkxFX1BPU1QJCT0gQklUKDIpLAo+ICsJS1ZNX1BHVEFCTEVfV0FMS19TSEFS
RUQJCQk9IEJJVCgzKSwKPiAgIH07Cj4gICAKPiAgIHN0cnVjdCBrdm1fcGd0YWJsZV92aXNpdF9j
dHggewo+IEBAIC0yMjMsNiArMjY3LDExIEBAIHN0cnVjdCBrdm1fcGd0YWJsZV92aXNpdF9jdHgg
ewo+ICAgdHlwZWRlZiBpbnQgKCprdm1fcGd0YWJsZV92aXNpdG9yX2ZuX3QpKGNvbnN0IHN0cnVj
dCBrdm1fcGd0YWJsZV92aXNpdF9jdHggKmN0eCwKPiAgIAkJCQkJZW51bSBrdm1fcGd0YWJsZV93
YWxrX2ZsYWdzIHZpc2l0KTsKPiAgIAo+ICtzdGF0aWMgaW5saW5lIGJvb2wga3ZtX3BndGFibGVf
d2Fsa19zaGFyZWQoY29uc3Qgc3RydWN0IGt2bV9wZ3RhYmxlX3Zpc2l0X2N0eCAqY3R4KQo+ICt7
Cj4gKwlyZXR1cm4gY3R4LT5mbGFncyAmIEtWTV9QR1RBQkxFX1dBTEtfU0hBUkVEOwo+ICt9Cj4g
Kwo+ICAgLyoqCj4gICAgKiBzdHJ1Y3Qga3ZtX3BndGFibGVfd2Fsa2VyIC0gSG9vayBpbnRvIGEg
cGFnZS10YWJsZSB3YWxrLgo+ICAgICogQGNiOgkJQ2FsbGJhY2sgZnVuY3Rpb24gdG8gaW52b2tl
IGR1cmluZyB0aGUgd2Fsay4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rdm0vaHlwL3BndGFi
bGUuYyBiL2FyY2gvYXJtNjQva3ZtL2h5cC9wZ3RhYmxlLmMKPiBpbmRleCA3Yzk3ODIzNDc1NzAu
LmQ4ZDk2MzUyMWQ0ZSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2t2bS9oeXAvcGd0YWJsZS5j
Cj4gKysrIGIvYXJjaC9hcm02NC9rdm0vaHlwL3BndGFibGUuYwo+IEBAIC0xNzEsNiArMTcxLDkg
QEAgc3RhdGljIGludCBrdm1fcGd0YWJsZV92aXNpdG9yX2NiKHN0cnVjdCBrdm1fcGd0YWJsZV93
YWxrX2RhdGEgKmRhdGEsCj4gICAJCQkJICBlbnVtIGt2bV9wZ3RhYmxlX3dhbGtfZmxhZ3Mgdmlz
aXQpCj4gICB7Cj4gICAJc3RydWN0IGt2bV9wZ3RhYmxlX3dhbGtlciAqd2Fsa2VyID0gZGF0YS0+
d2Fsa2VyOwo+ICsKPiArCS8qIEVuc3VyZSB0aGUgYXBwcm9wcmlhdGUgbG9jayBpcyBoZWxkIChl
LmcuIFJDVSBsb2NrIGZvciBzdGFnZS0yIE1NVSkgKi8KPiArCVdBUk5fT05fT05DRShrdm1fcGd0
YWJsZV93YWxrX3NoYXJlZChjdHgpICYmICFrdm1fcGd0YWJsZV93YWxrX2xvY2tfaGVsZCgpKTsK
PiAgIAlyZXR1cm4gd2Fsa2VyLT5jYihjdHgsIHZpc2l0KTsKPiAgIH0KPiAgIAo+IEBAIC0yODEs
OCArMjg0LDEzIEBAIGludCBrdm1fcGd0YWJsZV93YWxrKHN0cnVjdCBrdm1fcGd0YWJsZSAqcGd0
LCB1NjQgYWRkciwgdTY0IHNpemUsCj4gICAJCS5lbmQJPSBQQUdFX0FMSUdOKHdhbGtfZGF0YS5h
ZGRyICsgc2l6ZSksCj4gICAJCS53YWxrZXIJPSB3YWxrZXIsCj4gICAJfTsKPiArCWludCByOwo+
ICsKPiArCWt2bV9wZ3RhYmxlX3dhbGtfYmVnaW4oKTsKPiArCXIgPSBfa3ZtX3BndGFibGVfd2Fs
ayhwZ3QsICZ3YWxrX2RhdGEpOwo+ICsJa3ZtX3BndGFibGVfd2Fsa19lbmQoKTsKPiAgIAo+IC0J
cmV0dXJuIF9rdm1fcGd0YWJsZV93YWxrKHBndCwgJndhbGtfZGF0YSk7Cj4gKwlyZXR1cm4gcjsK
PiAgIH0KPiAgIAo+ICAgc3RydWN0IGxlYWZfd2Fsa19kYXRhIHsKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9rdm0vbW11LmMgYi9hcmNoL2FybTY0L2t2bS9tbXUuYwo+IGluZGV4IDczYWU5MDhl
YjVkOS4uNTJlMDQyMzk5YmE1IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQva3ZtL21tdS5jCj4g
KysrIGIvYXJjaC9hcm02NC9rdm0vbW11LmMKPiBAQCAtMTMwLDkgKzEzMCwyMSBAQCBzdGF0aWMg
dm9pZCBrdm1fczJfZnJlZV9wYWdlc19leGFjdCh2b2lkICp2aXJ0LCBzaXplX3Qgc2l6ZSkKPiAg
IAo+ICAgc3RhdGljIHN0cnVjdCBrdm1fcGd0YWJsZV9tbV9vcHMga3ZtX3MyX21tX29wczsKPiAg
IAo+ICtzdGF0aWMgdm9pZCBzdGFnZTJfZnJlZV9yZW1vdmVkX3RhYmxlX3JjdV9jYihzdHJ1Y3Qg
cmN1X2hlYWQgKmhlYWQpCj4gK3sKPiArCXN0cnVjdCBwYWdlICpwYWdlID0gY29udGFpbmVyX29m
KGhlYWQsIHN0cnVjdCBwYWdlLCByY3VfaGVhZCk7Cj4gKwl2b2lkICpwZ3RhYmxlID0gcGFnZV90
b192aXJ0KHBhZ2UpOwo+ICsJdTMyIGxldmVsID0gcGFnZV9wcml2YXRlKHBhZ2UpOwo+ICsKPiAr
CWt2bV9wZ3RhYmxlX3N0YWdlMl9mcmVlX3JlbW92ZWQoJmt2bV9zMl9tbV9vcHMsIHBndGFibGUs
IGxldmVsKTsKPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkIHN0YWdlMl9mcmVlX3JlbW92ZWRfdGFi
bGUodm9pZCAqYWRkciwgdTMyIGxldmVsKQo+ICAgewo+IC0Ja3ZtX3BndGFibGVfc3RhZ2UyX2Zy
ZWVfcmVtb3ZlZCgma3ZtX3MyX21tX29wcywgYWRkciwgbGV2ZWwpOwo+ICsJc3RydWN0IHBhZ2Ug
KnBhZ2UgPSB2aXJ0X3RvX3BhZ2UoYWRkcik7Cj4gKwo+ICsJc2V0X3BhZ2VfcHJpdmF0ZShwYWdl
LCAodW5zaWduZWQgbG9uZylsZXZlbCk7Cj4gKwljYWxsX3JjdSgmcGFnZS0+cmN1X2hlYWQsIHN0
YWdlMl9mcmVlX3JlbW92ZWRfdGFibGVfcmN1X2NiKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZv
aWQga3ZtX2hvc3RfZ2V0X3BhZ2Uodm9pZCAqYWRkcikKCkJlc3QgcmVnYXJkcwotLSAKTWFyZWsg
U3p5cHJvd3NraSwgUGhEClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QK
a3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVk
dS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=

Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7894662DA
	for <lists+kvmarm@lfdr.de>; Thu,  2 Dec 2021 12:54:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E0CEB4B17C;
	Thu,  2 Dec 2021 06:54:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3fkqhFSLCtn; Thu,  2 Dec 2021 06:54:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1FC24B21E;
	Thu,  2 Dec 2021 06:54:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 381CB4B175
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Dec 2021 06:54:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9wVBaGrDsco6 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Dec 2021 06:54:07 -0500 (EST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 536244B08F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Dec 2021 06:54:05 -0500 (EST)
Received: by mail-wr1-f41.google.com with SMTP id o13so58944868wrs.12
 for <kvmarm@lists.cs.columbia.edu>; Thu, 02 Dec 2021 03:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/LBdYv2lYLYBDxIekwtDzz8d//5GWBETro+YI4ZpZow=;
 b=VTXsF6KZoKkQQiPtCwAPE64D7b3Gtpr1vxL06ieVI3pE/LSYojY+dzURNptXJBa39+
 XMLR+FAuhUjATNejErvJwCF3jjdrEzQD3MzG/wBFDeaD42WHFqJUnN3GYsNUZKa6hzFq
 a7Y2VQfRaEJrveOde83iFjpSalHsv0ecMScWaPNTO17MIkI3z9gA1Ppuv3BCNb4OaSnz
 MbQOPuMYrXlv1cEVyWYfU+9KSPN0Os4ZKCuMpiQhIbjHDvdbRqI6wkerECdNwloCpAVL
 88wDO1T+rs4VJPA/fCcPNqjp+hpvxpRGRCiPVnN3s2hLe2pJVvpRJyHrRovx0o+LNhlw
 tIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/LBdYv2lYLYBDxIekwtDzz8d//5GWBETro+YI4ZpZow=;
 b=2gn/eN5+7kR4bvwIXoziWQWXeIIW/o3yqVLXtf8znWv0EiAJCzvCEG09NxvA4ZuVBM
 JwZt4fMGtkOxc8Eyrk3f0HQ3Nr6Pp3eNR0bGgsSSg2nfDiz4Kaf6UOAW5u5oFxC0kMOA
 bjf8b4xfHoLZ36XOQZJqZZurZ4bi23EWwnF1nGdkjNeOPNbIV+wpb1oGPOAxuIgqwzkm
 pPDna/+CT+7sGiSopkJ31+GLJp1Kzs6sbMhFoli5d8qh1EIiPbJox1NQq9vHKjSH6hiB
 rEmd0ao+LwP+GVQgHOG7xsY/UY+Z03kq7V1O/VXT3s99X7SC8y6k14tfso/NmUHUlzp6
 it9Q==
X-Gm-Message-State: AOAM5323AZwSZPbMi4jQmQcXhay8jyEGiLn7dUJij/glM9kCoBeR+Hg2
 V1QUg0FArBwRIcmRURdf4VM5Gg==
X-Google-Smtp-Source: ABdhPJz89w38JBp8UqdcLeWB4p3Jds0aNEVYioRX93sDZ1g2zjSMQpJaosSoF/HE9pDR6wgaSEm2Lw==
X-Received: by 2002:adf:dc12:: with SMTP id t18mr14173186wri.566.1638446044305; 
 Thu, 02 Dec 2021 03:54:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b15sm3233237wri.62.2021.12.02.03.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 03:53:59 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EF2F81FF9E;
 Thu,  2 Dec 2021 11:53:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: pbonzini@redhat.com,
	drjones@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v9 7/9] arm/barrier-litmus-tests: add simple mp
 and sal litmus tests
Date: Thu,  2 Dec 2021 11:53:50 +0000
Message-Id: <20211202115352.951548-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211202115352.951548-1-alex.bennee@linaro.org>
References: <20211202115352.951548-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, maz@kernel.org, christoffer.dall@arm.com,
 Will Deacon <will@kernel.org>, qemu-arm@nongnu.org,
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

VGhpcyBhZGRzIGEgZnJhbWV3b3JrIGZvciBhZGRpbmcgc2ltcGxlIGJhcnJpZXIgbGl0bXVzIHRl
c3RzIGFnYWluc3QKQVJNLiBUaGUgbGl0bXVzIHRlc3RzIGFyZW4ndCBhcyBjb21wcmVoZW5zaXZl
IGFzIHRoZSBhY2FkZW1pYyBleGVyY2lzZXMKd2hpY2ggd2lsbCBhdHRlbXB0IHRvIGRvIGFsbCBz
b3J0cyBvZiB0aGluZ3MgdG8ga2VlcCByYWNpbmcgQ1BVcyBzeW5jZWQKdXAuIFRoZXNlIHRlc3Rz
IGRvIGhvbm91ciB0aGUgInN5bmMiIHBhcmFtZXRlciB0byBkbyBhIHBvb3ItbWFucwplcXVpdmFs
ZW50LgoKVGhlIHR3byBsaXRtdXMgdGVzdHMgYXJlOgogIC0gbWVzc2FnZSBwYXNzaW5nCiAgLSBz
dG9yZS1hZnRlci1sb2FkCgpUaGV5IGJvdGggaGF2ZSBjYXNlIHRoYXQgc2hvdWxkIGZhaWwgKGFs
dGhvdWdoIHdvbid0IG9uIHNpbmdsZS10aHJlYWRlZApUQ0cgc2V0dXBzKS4gSWYgYmFycmllcnMg
YXJlbid0IHdvcmtpbmcgcHJvcGVybHkgdGhlIHN0b3JlLWFmdGVyLWxvYWQKdGVzdCB3aWxsIGZh
aWwgZXZlbiBvbiBhbiB4ODYgYmFja2VuZCBhcyB4ODYgYWxsb3dzIHJlLW9yZGluZyBvZiBub24K
YWxpYXNlZCBzdG9yZXMuCgpJJ3ZlIGltcG9ydGVkIGEgZmV3IG1vcmUgb2YgdGhlIGJhcnJpZXIg
cHJpbWF0aXZlcyBmcm9tIHRoZSBMaW51eCBzb3VyY2UKdHJlZSBzbyB3ZSBjb25zaXN0ZW50bHkg
dXNlIG1hY3Jvcy4KClRoZSBhcm02NCBiYXJyaWVyIHByaW1pdGl2ZXMgdHJpcCB1cCBvbiAtV3N0
cmljdC1hbGlhc2luZyBzbyB0aGlzIGlzCmRpc2FibGVkIGluIHRoZSBNYWtlZmlsZS4KClNpZ25l
ZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KQ0M6IFdpbGwg
RGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Ck1lc3NhZ2UtSWQ6IDwyMDIxMTExODE4NDY1MC42NjE1
NzUtOS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnPgoKLS0tCnY5CiAgLSByZXR1cm4gdG8gdW5pdHRl
c3RzLmNmZywgZHJvcCBhY2NlbD10Y2cKICAtIHVzZSBjb21waWxlci5oIGZvciBiYXJyaWVycyBp
bnN0ZWFkIG9mIGRlZmluaW5nIG91dHNlbHZlcwogIC0gcy9wcmludGYvcmVwb3J0X2luZm8vCi0t
LQogYXJtL01ha2VmaWxlLmNvbW1vbiAgICAgICB8ICAgMSArCiBsaWIvYXJtL2FzbS9iYXJyaWVy
LmggICAgIHwgIDE5ICsrCiBsaWIvYXJtNjQvYXNtL2JhcnJpZXIuaCAgIHwgIDUwICsrKysrCiBh
cm0vYmFycmllci1saXRtdXMtdGVzdC5jIHwgNDUwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiBhcm0vdW5pdHRlc3RzLmNmZyAgICAgICAgIHwgIDMxICsrKwogNSBmaWxl
cyBjaGFuZ2VkLCA1NTEgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFybS9iYXJy
aWVyLWxpdG11cy10ZXN0LmMKCmRpZmYgLS1naXQgYS9hcm0vTWFrZWZpbGUuY29tbW9uIGIvYXJt
L01ha2VmaWxlLmNvbW1vbgppbmRleCBmOTA1OTcxOC4uODYxZTVjN2YgMTAwNjQ0Ci0tLSBhL2Fy
bS9NYWtlZmlsZS5jb21tb24KKysrIGIvYXJtL01ha2VmaWxlLmNvbW1vbgpAQCAtMTMsNiArMTMs
NyBAQCB0ZXN0cy1jb21tb24gKz0gJChURVNUX0RJUikvc2lldmUuZmxhdAogdGVzdHMtY29tbW9u
ICs9ICQoVEVTVF9ESVIpL3BsMDMxLmZsYXQKIHRlc3RzLWNvbW1vbiArPSAkKFRFU1RfRElSKS90
bGJmbHVzaC1jb2RlLmZsYXQKIHRlc3RzLWNvbW1vbiArPSAkKFRFU1RfRElSKS9sb2NraW5nLXRl
c3QuZmxhdAordGVzdHMtY29tbW9uICs9ICQoVEVTVF9ESVIpL2JhcnJpZXItbGl0bXVzLXRlc3Qu
ZmxhdAogCiB0ZXN0cy1hbGwgPSAkKHRlc3RzLWNvbW1vbikgJCh0ZXN0cykKIGFsbDogZGlyZWN0
b3JpZXMgJCh0ZXN0cy1hbGwpCmRpZmYgLS1naXQgYS9saWIvYXJtL2FzbS9iYXJyaWVyLmggYi9s
aWIvYXJtL2FzbS9iYXJyaWVyLmgKaW5kZXggN2Y4NjgzMTQuLjBmMzY3MGI4IDEwMDY0NAotLS0g
YS9saWIvYXJtL2FzbS9iYXJyaWVyLmgKKysrIGIvbGliL2FybS9hc20vYmFycmllci5oCkBAIC04
LDYgKzgsOSBAQAogICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdQTCwgdmVyc2lvbiAyLgogICovCiAKKyNpbmNsdWRlIDxzdGRpbnQuaD4KKyNpbmNs
dWRlIDxsaW51eC9jb21waWxlci5oPgorCiAjZGVmaW5lIHNldigpCQlhc20gdm9sYXRpbGUoInNl
diIgOiA6IDogIm1lbW9yeSIpCiAjZGVmaW5lIHdmZSgpCQlhc20gdm9sYXRpbGUoIndmZSIgOiA6
IDogIm1lbW9yeSIpCiAjZGVmaW5lIHdmaSgpCQlhc20gdm9sYXRpbGUoIndmaSIgOiA6IDogIm1l
bW9yeSIpCkBAIC0yNSw0ICsyOCwyMCBAQAogI2RlZmluZSBzbXBfcm1iKCkJc21wX21iKCkKICNk
ZWZpbmUgc21wX3dtYigpCWRtYihpc2hzdCkKIAorZXh0ZXJuIHZvaWQgYWJvcnQodm9pZCk7CisK
KyNkZWZpbmUgc21wX3N0b3JlX3JlbGVhc2UocCwgdikJCQkJCQlcCitkbyB7CQkJCQkJCQkJXAor
CXNtcF9tYigpOwkJCQkJCQlcCisJV1JJVEVfT05DRSgqcCwgdik7CQkJCQkJXAorfSB3aGlsZSAo
MCkKKworCisjZGVmaW5lIHNtcF9sb2FkX2FjcXVpcmUocCkJCQkJCQlcCisoewkJCQkJCQkJCVwK
Kwl0eXBlb2YoKnApIF9fX3AxID0gUkVBRF9PTkNFKCpwKTsJCQkJXAorCXNtcF9tYigpOwkJCQkJ
CQlcCisJX19fcDE7CQkJCQkJCQlcCit9KQorCiAjZW5kaWYgLyogX0FTTUFSTV9CQVJSSUVSX0hf
ICovCmRpZmYgLS1naXQgYS9saWIvYXJtNjQvYXNtL2JhcnJpZXIuaCBiL2xpYi9hcm02NC9hc20v
YmFycmllci5oCmluZGV4IDBlMTkwNGNmLi41ZTQwNTE5MCAxMDA2NDQKLS0tIGEvbGliL2FybTY0
L2FzbS9iYXJyaWVyLmgKKysrIGIvbGliL2FybTY0L2FzbS9iYXJyaWVyLmgKQEAgLTI0LDQgKzI0
LDU0IEBACiAjZGVmaW5lIHNtcF9ybWIoKQlkbWIoaXNobGQpCiAjZGVmaW5lIHNtcF93bWIoKQlk
bWIoaXNoc3QpCiAKKyNkZWZpbmUgc21wX3N0b3JlX3JlbGVhc2UocCwgdikJCQkJCQlcCitkbyB7
CQkJCQkJCQkJXAorCXN3aXRjaCAoc2l6ZW9mKCpwKSkgewkJCQkJCVwKKwljYXNlIDE6CQkJCQkJ
CQlcCisJCWFzbSB2b2xhdGlsZSAoInN0bHJiICV3MSwgJTAiCQkJCVwKKwkJCQk6ICI9USIgKCpw
KSA6ICJyIiAodikgOiAibWVtb3J5Iik7CVwKKwkJYnJlYWs7CQkJCQkJCVwKKwljYXNlIDI6CQkJ
CQkJCQlcCisJCWFzbSB2b2xhdGlsZSAoInN0bHJoICV3MSwgJTAiCQkJCVwKKwkJCQk6ICI9USIg
KCpwKSA6ICJyIiAodikgOiAibWVtb3J5Iik7CVwKKwkJYnJlYWs7CQkJCQkJCVwKKwljYXNlIDQ6
CQkJCQkJCQlcCisJCWFzbSB2b2xhdGlsZSAoInN0bHIgJXcxLCAlMCIJCQkJXAorCQkJCTogIj1R
IiAoKnApIDogInIiICh2KSA6ICJtZW1vcnkiKTsJXAorCQlicmVhazsJCQkJCQkJXAorCWNhc2Ug
ODoJCQkJCQkJCVwKKwkJYXNtIHZvbGF0aWxlICgic3RsciAlMSwgJTAiCQkJCVwKKwkJCQk6ICI9
USIgKCpwKSA6ICJyIiAodikgOiAibWVtb3J5Iik7CVwKKwkJYnJlYWs7CQkJCQkJCVwKKwl9CQkJ
CQkJCQlcCit9IHdoaWxlICgwKQorCisjZGVmaW5lIHNtcF9sb2FkX2FjcXVpcmUocCkJCQkJCQlc
CisoewkJCQkJCQkJCVwKKwl1bmlvbiB7IHR5cGVvZigqcCkgX192YWw7IGNoYXIgX19jWzFdOyB9
IF9fdTsJCQlcCisJc3dpdGNoIChzaXplb2YoKnApKSB7CQkJCQkJXAorCWNhc2UgMToJCQkJCQkJ
CVwKKwkJYXNtIHZvbGF0aWxlICgibGRhcmIgJXcwLCAlMSIJCQkJXAorCQkJOiAiPXIiICgqKHU4
ICopX191Ll9fYykJCQkJXAorCQkJOiAiUSIgKCpwKSA6ICJtZW1vcnkiKTsJCQkJXAorCQlicmVh
azsJCQkJCQkJXAorCWNhc2UgMjoJCQkJCQkJCVwKKwkJYXNtIHZvbGF0aWxlICgibGRhcmggJXcw
LCAlMSIJCQkJXAorCQkJOiAiPXIiICgqKHUxNiAqKV9fdS5fX2MpCQkJXAorCQkJOiAiUSIgKCpw
KSA6ICJtZW1vcnkiKTsJCQkJXAorCQlicmVhazsJCQkJCQkJXAorCWNhc2UgNDoJCQkJCQkJCVwK
KwkJYXNtIHZvbGF0aWxlICgibGRhciAldzAsICUxIgkJCQlcCisJCQk6ICI9ciIgKCoodTMyICop
X191Ll9fYykJCQlcCisJCQk6ICJRIiAoKnApIDogIm1lbW9yeSIpOwkJCQlcCisJCWJyZWFrOwkJ
CQkJCQlcCisJY2FzZSA4OgkJCQkJCQkJXAorCQlhc20gdm9sYXRpbGUgKCJsZGFyICUwLCAlMSIJ
CQkJXAorCQkJOiAiPXIiICgqKHU2NCAqKV9fdS5fX2MpCQkJXAorCQkJOiAiUSIgKCpwKSA6ICJt
ZW1vcnkiKTsJCQkJXAorCQlicmVhazsJCQkJCQkJXAorCX0JCQkJCQkJCVwKKwlfX3UuX192YWw7
CQkJCQkJCVwKK30pCisKICNlbmRpZiAvKiBfQVNNQVJNNjRfQkFSUklFUl9IXyAqLwpkaWZmIC0t
Z2l0IGEvYXJtL2JhcnJpZXItbGl0bXVzLXRlc3QuYyBiL2FybS9iYXJyaWVyLWxpdG11cy10ZXN0
LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAuLjVkN2U2MWQxCi0tLSAvZGV2
L251bGwKKysrIGIvYXJtL2JhcnJpZXItbGl0bXVzLXRlc3QuYwpAQCAtMCwwICsxLDQ1MCBAQAor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKy8qCisgKiBBUk0g
QmFycmllciBMaXRtdXMgVGVzdHMKKyAqCisgKiBUaGlzIHRlc3QgcHJvdmlkZXMgYSBmcmFtZXdv
cmsgZm9yIHRlc3RpbmcgYmFycmllciBjb25kaXRpb25zIG9uCisgKiB0aGUgcHJvY2Vzc29yLiBJ
dCdzIHNpbXBsZXIgdGhhbiB0aGUgbW9yZSBpbnZvbHZlZCBiYXJyaWVyIHRlc3RpbmcKKyAqIGZy
YW1ld29ya3MgYXMgd2UgYXJlIGxvb2tpbmcgZm9yIHNpbXBsZSBmYWlsdXJlcyBvZiBRRU1VJ3Mg
VENHIG5vdAorICogd2VpcmQgZWRnZSBjYXNlcyB0aGUgc2lsaWNvbiBnZXRzIHdyb25nLgorICov
CisKKyNpbmNsdWRlIDxsaWJjZmxhdC5oPgorI2luY2x1ZGUgPGFzbS9zbXAuaD4KKyNpbmNsdWRl
IDxhc20vY3B1bWFzay5oPgorI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+CisjaW5jbHVkZSA8YXNt
L21tdS5oPgorCisjZGVmaW5lIE1BWF9DUFVTIDgKKworLyogQXJyYXkgc2l6ZSBhbmQgYWNjZXNz
IGNvbnRyb2xzICovCitzdGF0aWMgaW50IGFycmF5X3NpemUgPSAxMDAwMDA7CitzdGF0aWMgaW50
IHdhaXRfaWZfYWhlYWQ7CisKK3N0YXRpYyBjcHVtYXNrX3QgY3B1X21hc2s7CisKKy8qCisgKiBU
aGVzZSB0ZXN0X2FycmF5Xyogc3RydWN0dXJlcyBhcmUgYSBjb250aWd1b3VzIGFycmF5IG1vZGlm
aWVkIGJ5IHR3byBvciBtb3JlCisgKiBjb21wZXRpbmcgQ1BVcy4gVGhlIHBhZGRpbmcgaXMgdG8g
ZW5zdXJlIHRoZSB2YXJpYWJsZXMgZG8gbm90IHNoYXJlCisgKiBjYWNoZSBsaW5lcy4KKyAqCisg
KiBBbGwgc3RydWN0dXJlcyBzdGFydCB6ZXJvZWQuCisgKi8KKwordHlwZWRlZiBzdHJ1Y3QgdGVz
dF9hcnJheSB7CisJdm9sYXRpbGUgdW5zaWduZWQgaW50IHg7CisJdWludDhfdCBkdW1teVs2NF07
CisJdm9sYXRpbGUgdW5zaWduZWQgaW50IHk7CisJdWludDhfdCBkdW1teTJbNjRdOworCXZvbGF0
aWxlIHVuc2lnbmVkIGludCByW01BWF9DUFVTXTsKK30gdGVzdF9hcnJheTsKKwordm9sYXRpbGUg
dGVzdF9hcnJheSAqYXJyYXk7CisKKy8qIFRlc3QgZGVmaW5pdGlvbiBzdHJ1Y3R1cmUKKyAqCisg
KiBUaGUgZmlyc3QgZnVuY3Rpb24gd2lsbCBhbHdheXMgcnVuIG9uIHRoZSBwcmltYXJ5IENQVSwg
aXQgaXMKKyAqIHVzdWFsbHkgdGhlIG9uZSB0aGF0IHdpbGwgZGV0ZWN0IGFueSB3ZWlyZG5lc3Mg
YW5kIHRyaWdnZXIgdGhlCisgKiBmYWlsdXJlIG9mIHRoZSB0ZXN0LgorICovCisKK3R5cGVkZWYg
dm9pZCAoKnRlc3RfZm4pKHZvaWQpOworCit0eXBlZGVmIHN0cnVjdCB7CisJY29uc3QgY2hhciAq
dGVzdF9uYW1lOworCWJvb2wgIHNob3VsZF9wYXNzOworCXRlc3RfZm4gbWFpbl9mbjsKKwl0ZXN0
X2ZuIHNlY29uZGFyeV9mbnNbTUFYX0NQVVMtMV07Cit9IHRlc3RfZGVzY3JfdDsKKworLyogTGl0
bXVzIHRlc3RzICovCisKK3N0YXRpYyB1bnNpZ25lZCBsb25nIHN5bmNfc3RhcnQodm9pZCkKK3sK
Kwljb25zdCB1bnNpZ25lZCBsb25nIGdhdGVfbWFzayA9IH4weDNmZmZmOworCXVuc2lnbmVkIGxv
bmcgZ2F0ZSwgbm93OworCisJZ2F0ZSA9IGdldF9jbnR2Y3QoKSAmIGdhdGVfbWFzazsKKwlkbyB7
CisJCW5vdyA9IGdldF9jbnR2Y3QoKTsKKwl9IHdoaWxlICgobm93ICYgZ2F0ZV9tYXNrKSA9PSBn
YXRlKTsKKworCXJldHVybiBub3c7Cit9CisKKy8qIFNpbXBsZSBNZXNzYWdlIFBhc3NpbmcKKyAq
CisgKiB4IGlzIHRoZSBtZXNzYWdlIGRhdGEKKyAqIHkgaXMgdGhlIGZsYWcgdG8gaW5kaWNhdGUg
dGhlIGRhdGEgaXMgcmVhZHkKKyAqCisgKiBSZWFkaW5nIHggPT0gMCB3aGVuIHkgPT0gMSBpcyBh
IGZhaWx1cmUuCisgKi8KKworc3RhdGljIHZvaWQgbWVzc2FnZV9wYXNzaW5nX3dyaXRlKHZvaWQp
Cit7CisJaW50IGk7CisKKwlzeW5jX3N0YXJ0KCk7CisJZm9yIChpID0gMDsgaSA8IGFycmF5X3Np
emU7IGkrKykgeworCQl2b2xhdGlsZSB0ZXN0X2FycmF5ICplbnRyeSA9ICZhcnJheVtpXTsKKwor
CQllbnRyeS0+eCA9IDE7CisJCWVudHJ5LT55ID0gMTsKKwl9CisKKwloYWx0KCk7Cit9CisKK3N0
YXRpYyB2b2lkIG1lc3NhZ2VfcGFzc2luZ19yZWFkKHZvaWQpCit7CisJaW50IGk7CisJaW50IGVy
cm9ycyA9IDAsIHJlYWR5ID0gMDsKKworCXN5bmNfc3RhcnQoKTsKKwlmb3IgKGkgPSAwOyBpIDwg
YXJyYXlfc2l6ZTsgaSsrKSB7CisJCXZvbGF0aWxlIHRlc3RfYXJyYXkgKmVudHJ5ID0gJmFycmF5
W2ldOworCQl1bnNpZ25lZCBpbnQgeCwgeTsKKworCQl5ID0gZW50cnktPnk7CisJCXggPSBlbnRy
eS0+eDsKKworCQlpZiAoeSAmJiAheCkKKwkJCWVycm9ycysrOworCQlyZWFkeSArPSB5OworCX0K
KworCS8qCisJICogV2UgZXhwZWN0IHRoaXMgdG8gZmFpbCBidXQgd2l0aCBTVE8gYmFja2VuZHMg
eW91IG9mdGVuIGdldAorCSAqIGF3YXkgd2l0aCBpdC4gRnVkZ2UgeGZhaWwgaWYgd2UgZGlkIGFj
dHVhbGx5IHBhc3MuCisJICovCisJcmVwb3J0X3hmYWlsKGVycm9ycyA9PSAwID8gZmFsc2UgOiB0
cnVlLCBlcnJvcnMgPT0gMCwKKwkJICAgICAibXA6ICVkIGVycm9ycywgJWQgcmVhZHkiLCBlcnJv
cnMsIHJlYWR5KTsKK30KKworLyogU2ltcGxlIE1lc3NhZ2UgUGFzc2luZyB3aXRoIGJhcnJpZXJz
ICovCitzdGF0aWMgdm9pZCBtZXNzYWdlX3Bhc3Npbmdfd3JpdGVfYmFycmllcih2b2lkKQorewor
CWludCBpOworCisJc3luY19zdGFydCgpOworCWZvciAoaSA9IDA7IGkgPCBhcnJheV9zaXplOyBp
KyspIHsKKwkJdm9sYXRpbGUgdGVzdF9hcnJheSAqZW50cnkgPSAmYXJyYXlbaV07CisKKwkJZW50
cnktPnggPSAxOworCQlzbXBfd21iKCk7CisJCWVudHJ5LT55ID0gMTsKKwl9CisKKwloYWx0KCk7
Cit9CisKK3N0YXRpYyB2b2lkIG1lc3NhZ2VfcGFzc2luZ19yZWFkX2JhcnJpZXIodm9pZCkKK3sK
KwlpbnQgaTsKKwlpbnQgZXJyb3JzID0gMCwgcmVhZHkgPSAwLCBub3RfcmVhZHkgPSAwOworCisJ
c3luY19zdGFydCgpOworCWZvciAoaSA9IDA7IGkgPCBhcnJheV9zaXplOyBpKyspIHsKKwkJdm9s
YXRpbGUgdGVzdF9hcnJheSAqZW50cnkgPSAmYXJyYXlbaV07CisJCXVuc2lnbmVkIGludCB4LCB5
OworCisJCXkgPSBlbnRyeS0+eTsKKwkJc21wX3JtYigpOworCQl4ID0gZW50cnktPng7CisKKwkJ
aWYgKHkgJiYgIXgpCisJCQllcnJvcnMrKzsKKworCQlpZiAoeSkgeworCQkJcmVhZHkrKzsKKwkJ
fSBlbHNlIHsKKwkJCW5vdF9yZWFkeSsrOworCisJCQlpZiAobm90X3JlYWR5ID4gMikgeworCQkJ
CWVudHJ5ID0gJmFycmF5W2krMV07CisJCQkJZG8geworCQkJCQlub3RfcmVhZHkgPSAwOworCQkJ
CX0gd2hpbGUgKHdhaXRfaWZfYWhlYWQgJiYgIWVudHJ5LT55KTsKKwkJCX0KKwkJfQorCX0KKwor
CXJlcG9ydChlcnJvcnMgPT0gMCwgIm1wIGJhcnJpZXI6ICVkIGVycm9ycywgJWQgcmVhZHkiLCBl
cnJvcnMsIHJlYWR5KTsKK30KKworLyogU2ltcGxlIE1lc3NhZ2UgUGFzc2luZyB3aXRoIEFjcXVp
cmUvUmVsZWFzZSAqLworc3RhdGljIHZvaWQgbWVzc2FnZV9wYXNzaW5nX3dyaXRlX3JlbGVhc2Uo
dm9pZCkKK3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBhcnJheV9zaXplOyBpKyspIHsK
KwkJdm9sYXRpbGUgdGVzdF9hcnJheSAqZW50cnkgPSAmYXJyYXlbaV07CisKKwkJZW50cnktPngg
PSAxOworCQlzbXBfc3RvcmVfcmVsZWFzZSgmZW50cnktPnksIDEpOworCX0KKworCWhhbHQoKTsK
K30KKworc3RhdGljIHZvaWQgbWVzc2FnZV9wYXNzaW5nX3JlYWRfYWNxdWlyZSh2b2lkKQorewor
CWludCBpOworCWludCBlcnJvcnMgPSAwLCByZWFkeSA9IDAsIG5vdF9yZWFkeSA9IDA7CisKKwlm
b3IgKGkgPSAwOyBpIDwgYXJyYXlfc2l6ZTsgaSsrKSB7CisJCXZvbGF0aWxlIHRlc3RfYXJyYXkg
KmVudHJ5ID0gJmFycmF5W2ldOworCQl1bnNpZ25lZCBpbnQgeCwgeTsKKworCQl5ID0gc21wX2xv
YWRfYWNxdWlyZSgmZW50cnktPnkpOworCQl4ID0gZW50cnktPng7CisKKwkJaWYgKHkgJiYgIXgp
CisJCQllcnJvcnMrKzsKKworCQlpZiAoeSkgeworCQkJcmVhZHkrKzsKKwkJfSBlbHNlIHsKKwkJ
CW5vdF9yZWFkeSsrOworCisJCQlpZiAobm90X3JlYWR5ID4gMikgeworCQkJCWVudHJ5ID0gJmFy
cmF5W2krMV07CisJCQkJZG8geworCQkJCQlub3RfcmVhZHkgPSAwOworCQkJCX0gd2hpbGUgKHdh
aXRfaWZfYWhlYWQgJiYgIWVudHJ5LT55KTsKKwkJCX0KKwkJfQorCX0KKworCXJlcG9ydChlcnJv
cnMgPT0gMCwgIm1wIGFjcXJlbDogJWQgZXJyb3JzLCAlZCByZWFkeSIsIGVycm9ycywgcmVhZHkp
OworfQorCisvKgorICogU3RvcmUgYWZ0ZXIgbG9hZAorICoKKyAqIFQxOiB3cml0ZSAxIHRvIHgs
IGxvYWQgciBmcm9tIHkKKyAqIFQyOiB3cml0ZSAxIHRvIHksIGxvYWQgciBmcm9tIHgKKyAqCisg
KiBXaXRob3V0IG1lbW9yeSBmZW5jZSByWzBdICYmIHJbMV0gPT0gMAorICogV2l0aCBtZW1vcnkg
ZmVuY2UgYm90aCA9PSAwIHNob3VsZCBiZSBpbXBvc3NpYmxlCisgKi8KKworc3RhdGljIHZvaWQg
Y2hlY2tfc3RvcmVfYW5kX2xvYWRfcmVzdWx0cyhjb25zdCBjaGFyICpuYW1lLCBpbnQgdGhyZWFk
LAorCQkJCQkgYm9vbCB4ZmFpbCwgdW5zaWduZWQgbG9uZyBzdGFydCwKKwkJCQkJIHVuc2lnbmVk
IGxvbmcgZW5kKQoreworCWludCBpOworCWludCBuZWl0aGVyID0gMDsKKwlpbnQgb25seV9maXJz
dCA9IDA7CisJaW50IG9ubHlfc2Vjb25kID0gMDsKKwlpbnQgYm90aCA9IDA7CisKKwlmb3IgKCBp
PSAwOyBpIDwgYXJyYXlfc2l6ZTsgaSsrKSB7CisJCXZvbGF0aWxlIHRlc3RfYXJyYXkgKmVudHJ5
ID0gJmFycmF5W2ldOworCisJCWlmIChlbnRyeS0+clswXSA9PSAwICYmCisJCSAgICBlbnRyeS0+
clsxXSA9PSAwKQorCQkJbmVpdGhlcisrOworCQllbHNlIGlmIChlbnRyeS0+clswXSAmJgorCQkJ
ZW50cnktPnJbMV0pCisJCQlib3RoKys7CisJCWVsc2UgaWYgKGVudHJ5LT5yWzBdKQorCQkJb25s
eV9maXJzdCsrOworCQllbHNlCisJCQlvbmx5X3NlY29uZCsrOworCX0KKworCXJlcG9ydF9pbmZv
KCJUJWQ6ICUwOGx4LT4lMDhseCBuZWl0aGVyPSVkIG9ubHlfdDE9JWQgb25seV90Mj0lZCBib3Ro
PSVkXG4iLAorCQkgICAgdGhyZWFkLCBzdGFydCwgZW5kLCBuZWl0aGVyLCBvbmx5X2ZpcnN0LCBv
bmx5X3NlY29uZCwgYm90aCk7CisKKwlpZiAodGhyZWFkID09IDEpCisJCXJlcG9ydF94ZmFpbCh4
ZmFpbCwgbmVpdGhlcj09MCwgIiVzOiBlcnJvcnM9JWQiLCBuYW1lLCBuZWl0aGVyKTsKKworfQor
CisvKgorICogVGhpcyBhdHRlbXB0cyB0byBzeW5jaHJvbmlzZSB0aGUgc3RhcnQgb2YgYm90aCB0
aHJlYWRzIHRvIHJvdWdobHkKKyAqIHRoZSBzYW1lIHRpbWUuIE9uIHJlYWwgaGFyZHdhcmUgdGhl
cmUgaXMgYSBsaXR0bGUgbGF0ZW5jeSBhcyB0aGUKKyAqIHNlY29uZGFyeSB2Q1BVcyBhcmUgcG93
ZXJlZCB1cCBob3dldmVyIHRoaXMgZWZmZWN0IGl0IG11Y2ggbW9yZQorICogZXhhZ2dlcmF0ZWQg
b24gYSBUQ0cgaG9zdC4KKyAqCisgKiBCdXN5IHdhaXRzIHVudGlsIHRoZSB3ZSBwYXNzIGEgZnV0
dXJlIHBvaW50IGluIHRpbWUsIHJldHVybnMgZmluYWwKKyAqIHN0YXJ0IHRpbWUuCisgKi8KKwor
c3RhdGljIHZvaWQgc3RvcmVfYW5kX2xvYWRfMSh2b2lkKQoreworCWludCBpOworCXVuc2lnbmVk
IGxvbmcgc3RhcnQsIGVuZDsKKworCXN0YXJ0ID0gc3luY19zdGFydCgpOworCWZvciAoaSA9IDA7
IGkgPCBhcnJheV9zaXplOyBpKyspIHsKKwkJdm9sYXRpbGUgdGVzdF9hcnJheSAqZW50cnkgPSAm
YXJyYXlbaV07CisJCXVuc2lnbmVkIGludCByOworCisJCWVudHJ5LT54ID0gMTsKKwkJciA9IGVu
dHJ5LT55OworCQllbnRyeS0+clswXSA9IHI7CisJfQorCWVuZCA9IGdldF9jbnR2Y3QoKTsKKwor
CXNtcF9tYigpOworCisJd2hpbGUgKCFjcHVtYXNrX3Rlc3RfY3B1KDEsICZjcHVfbWFzaykpCisJ
CWNwdV9yZWxheCgpOworCisJY2hlY2tfc3RvcmVfYW5kX2xvYWRfcmVzdWx0cygic2FsIiwgMSwg
dHJ1ZSwgc3RhcnQsIGVuZCk7Cit9CisKK3N0YXRpYyB2b2lkIHN0b3JlX2FuZF9sb2FkXzIodm9p
ZCkKK3sKKwlpbnQgaTsKKwl1bnNpZ25lZCBsb25nIHN0YXJ0LCBlbmQ7CisKKwlzdGFydCA9IHN5
bmNfc3RhcnQoKTsKKwlmb3IgKGkgPSAwOyBpIDwgYXJyYXlfc2l6ZTsgaSsrKSB7CisJCXZvbGF0
aWxlIHRlc3RfYXJyYXkgKmVudHJ5ID0gJmFycmF5W2ldOworCQl1bnNpZ25lZCBpbnQgcjsKKwor
CQllbnRyeS0+eSA9IDE7CisJCXIgPSBlbnRyeS0+eDsKKwkJZW50cnktPnJbMV0gPSByOworCX0K
KwllbmQgPSBnZXRfY250dmN0KCk7CisKKwljaGVja19zdG9yZV9hbmRfbG9hZF9yZXN1bHRzKCJz
YWwiLCAyLCB0cnVlLCBzdGFydCwgZW5kKTsKKworCWNwdW1hc2tfc2V0X2NwdSgxLCAmY3B1X21h
c2spOworCisJaGFsdCgpOworfQorCitzdGF0aWMgdm9pZCBzdG9yZV9hbmRfbG9hZF9iYXJyaWVy
XzEodm9pZCkKK3sKKwlpbnQgaTsKKwl1bnNpZ25lZCBsb25nIHN0YXJ0LCBlbmQ7CisKKwlzdGFy
dCA9IHN5bmNfc3RhcnQoKTsKKwlmb3IgKGkgPSAwOyBpIDwgYXJyYXlfc2l6ZTsgaSsrKSB7CisJ
CXZvbGF0aWxlIHRlc3RfYXJyYXkgKmVudHJ5ID0gJmFycmF5W2ldOworCQl1bnNpZ25lZCBpbnQg
cjsKKworCQllbnRyeS0+eCA9IDE7CisJCXNtcF9tYigpOworCQlyID0gZW50cnktPnk7CisJCWVu
dHJ5LT5yWzBdID0gcjsKKwl9CisJZW5kID0gZ2V0X2NudHZjdCgpOworCisJc21wX21iKCk7CisK
Kwl3aGlsZSAoIWNwdW1hc2tfdGVzdF9jcHUoMSwgJmNwdV9tYXNrKSkKKwkJY3B1X3JlbGF4KCk7
CisKKwljaGVja19zdG9yZV9hbmRfbG9hZF9yZXN1bHRzKCJzYWxfYmFycmllciIsIDEsIGZhbHNl
LCBzdGFydCwgZW5kKTsKK30KKworc3RhdGljIHZvaWQgc3RvcmVfYW5kX2xvYWRfYmFycmllcl8y
KHZvaWQpCit7CisJaW50IGk7CisJdW5zaWduZWQgbG9uZyBzdGFydCwgZW5kOworCisJc3RhcnQg
PSBzeW5jX3N0YXJ0KCk7CisJZm9yIChpID0gMDsgaSA8IGFycmF5X3NpemU7IGkrKykgeworCQl2
b2xhdGlsZSB0ZXN0X2FycmF5ICplbnRyeSA9ICZhcnJheVtpXTsKKwkJdW5zaWduZWQgaW50IHI7
CisKKwkJZW50cnktPnkgPSAxOworCQlzbXBfbWIoKTsKKwkJciA9IGVudHJ5LT54OworCQllbnRy
eS0+clsxXSA9IHI7CisJfQorCWVuZCA9IGdldF9jbnR2Y3QoKTsKKworCWNoZWNrX3N0b3JlX2Fu
ZF9sb2FkX3Jlc3VsdHMoInNhbF9iYXJyaWVyIiwgMiwgZmFsc2UsIHN0YXJ0LCBlbmQpOworCisJ
Y3B1bWFza19zZXRfY3B1KDEsICZjcHVfbWFzayk7CisKKwloYWx0KCk7Cit9CisKKworLyogVGVz
dCBhcnJheSAqLworc3RhdGljIHRlc3RfZGVzY3JfdCB0ZXN0c1tdID0geworCisJeyAibXAiLCAg
ICAgICAgIGZhbHNlLAorCSAgbWVzc2FnZV9wYXNzaW5nX3JlYWQsCisJICB7IG1lc3NhZ2VfcGFz
c2luZ193cml0ZSB9CisJfSwKKworCXsgIm1wX2JhcnJpZXIiLCB0cnVlLAorCSAgbWVzc2FnZV9w
YXNzaW5nX3JlYWRfYmFycmllciwKKwkgIHsgbWVzc2FnZV9wYXNzaW5nX3dyaXRlX2JhcnJpZXIg
fQorCX0sCisKKwl7ICJtcF9hY3FyZWwiLCB0cnVlLAorCSAgbWVzc2FnZV9wYXNzaW5nX3JlYWRf
YWNxdWlyZSwKKwkgIHsgbWVzc2FnZV9wYXNzaW5nX3dyaXRlX3JlbGVhc2UgfQorCX0sCisKKwl7
ICJzYWwiLCAgICAgICBmYWxzZSwKKwkgIHN0b3JlX2FuZF9sb2FkXzEsCisJICB7IHN0b3JlX2Fu
ZF9sb2FkXzIgfQorCX0sCisKKwl7ICJzYWxfYmFycmllciIsIHRydWUsCisJICBzdG9yZV9hbmRf
bG9hZF9iYXJyaWVyXzEsCisJICB7IHN0b3JlX2FuZF9sb2FkX2JhcnJpZXJfMiB9CisJfSwKK307
CisKKworc3RhdGljIHZvaWQgc2V0dXBfYW5kX3J1bl9saXRtdXModGVzdF9kZXNjcl90ICp0ZXN0
KQoreworCWFycmF5ID0gY2FsbG9jKGFycmF5X3NpemUsIHNpemVvZih0ZXN0X2FycmF5KSk7CisK
KwlpZiAoYXJyYXkpIHsKKwkJaW50IGkgPSAwOworCisJCXJlcG9ydF9pbmZvKCJBbGxvY2F0ZWQg
dGVzdCBhcnJheSBAICVwIiwgYXJyYXkpOworCisJCXdoaWxlICh0ZXN0LT5zZWNvbmRhcnlfZm5z
W2ldKSB7CisJCQlzbXBfYm9vdF9zZWNvbmRhcnkoaSsxLCB0ZXN0LT5zZWNvbmRhcnlfZm5zW2ld
KTsKKwkJCWkrKzsKKwkJfQorCisJCXRlc3QtPm1haW5fZm4oKTsKKwl9IGVsc2UKKwkJcmVwb3J0
KGZhbHNlLCAiJXM6IGZhaWxlZCB0byBhbGxvY2F0ZSBtZW1vcnkiLCB0ZXN0LT50ZXN0X25hbWUp
OworfQorCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCit7CisJaW50IGk7CisJdW5z
aWduZWQgaW50IGo7CisJdGVzdF9kZXNjcl90ICp0ZXN0ID0gTlVMTDsKKworCWZvciAoaSA9IDA7
IGkgPCBhcmdjOyBpKyspIHsKKwkJY2hhciAqYXJnID0gYXJndltpXTsKKworCQlmb3IgKGogPSAw
OyBqIDwgQVJSQVlfU0laRSh0ZXN0cyk7IGorKykgeworCQkJaWYgKHN0cmNtcChhcmcsIHRlc3Rz
W2pdLnRlc3RfbmFtZSkgPT0gMCkKKwkJCQl0ZXN0ID0gJnRlc3RzW2pdOworCQl9CisKKwkJLyog
VGVzdCBtb2RpZmllcnMgKi8KKwkJaWYgKHN0cnN0cihhcmcsICJjb3VudD0iKSAhPSBOVUxMKSB7
CisJCQljaGFyICpwID0gc3Ryc3RyKGFyZywgIj0iKTsKKworCQkJYXJyYXlfc2l6ZSA9IGF0b2wo
cCsxKTsKKwkJfSBlbHNlIGlmIChzdHJjbXAoYXJnLCAid2FpdCIpID09IDApIHsKKwkJCXdhaXRf
aWZfYWhlYWQgPSAxOworCQl9CisJfQorCisJaWYgKHRlc3QpCisJCXNldHVwX2FuZF9ydW5fbGl0
bXVzKHRlc3QpOworCWVsc2UKKwkJcmVwb3J0KGZhbHNlLCAiVW5rbm93biB0ZXN0Iik7CisKKwly
ZXR1cm4gcmVwb3J0X3N1bW1hcnkoKTsKK30KZGlmZiAtLWdpdCBhL2FybS91bml0dGVzdHMuY2Zn
IGIvYXJtL3VuaXR0ZXN0cy5jZmcKaW5kZXggMGE3NTc1NTYuLjYwN2Y1NjQxIDEwMDY0NAotLS0g
YS9hcm0vdW5pdHRlc3RzLmNmZworKysgYi9hcm0vdW5pdHRlc3RzLmNmZwpAQCAtMjk2LDMgKzI5
NiwzNCBAQCBzbXAgPSAkKCgkTUFYX1NNUD40PzQ6JE1BWF9TTVApKQogZXh0cmFfcGFyYW1zID0g
LWFwcGVuZCAnZXhjbCcKIGdyb3VwcyA9IG5vZGVmYXVsdCBtdHRjZyBsb2NraW5nCiAKKyMgQmFy
cmllciBMaXRtdXMgdGVzdHMKK1tiYXJyaWVyLWxpdG11czo6bXBdCitmaWxlID0gYmFycmllci1s
aXRtdXMtdGVzdC5mbGF0CitzbXAgPSAyCitleHRyYV9wYXJhbXMgPSAtYXBwZW5kICdtcCcKK2dy
b3VwcyA9IG5vZGVmYXVsdCBtdHRjZyBiYXJyaWVyCisKK1tiYXJyaWVyLWxpdG11czo6bXAtYmFy
cmllcl0KK2ZpbGUgPSBiYXJyaWVyLWxpdG11cy10ZXN0LmZsYXQKK3NtcCA9IDIKK2V4dHJhX3Bh
cmFtcyA9IC1hcHBlbmQgJ21wX2JhcnJpZXInCitncm91cHMgPSBub2RlZmF1bHQgbXR0Y2cgYmFy
cmllcgorCitbYmFycmllci1saXRtdXM6Om1wLWFjcXJlbF0KK2ZpbGUgPSBiYXJyaWVyLWxpdG11
cy10ZXN0LmZsYXQKK3NtcCA9IDIKK2V4dHJhX3BhcmFtcyA9IC1hcHBlbmQgJ21wX2FjcXJlbCcK
K2dyb3VwcyA9IG5vZGVmYXVsdCBtdHRjZyBiYXJyaWVyCisKK1tiYXJyaWVyLWxpdG11czo6c2Fs
XQorZmlsZSA9IGJhcnJpZXItbGl0bXVzLXRlc3QuZmxhdAorc21wID0gMgorZXh0cmFfcGFyYW1z
ID0gLWFwcGVuZCAnc2FsJworZ3JvdXBzID0gbm9kZWZhdWx0IG10dGNnIGJhcnJpZXIKKworW2Jh
cnJpZXItbGl0bXVzOjpzYWwtYmFycmllcl0KK2ZpbGUgPSBiYXJyaWVyLWxpdG11cy10ZXN0LmZs
YXQKK3NtcCA9IDIKK2V4dHJhX3BhcmFtcyA9IC1hcHBlbmQgJ3NhbF9iYXJyaWVyJworZ3JvdXBz
ID0gbm9kZWZhdWx0IG10dGNnIGJhcnJpZXIKKwotLSAKMi4zMC4yCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFy
bUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFp
bG1hbi9saXN0aW5mby9rdm1hcm0K

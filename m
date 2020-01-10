Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF013723F
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jan 2020 17:05:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8412D4B131;
	Fri, 10 Jan 2020 11:05:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JjNDhkz1F29I; Fri, 10 Jan 2020 11:05:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A6F84B183;
	Fri, 10 Jan 2020 11:05:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EBB24B170
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 11:05:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jTqRMcYM3cGy for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jan 2020 11:05:26 -0500 (EST)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 78AA24AF63
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 11:05:26 -0500 (EST)
Received: by mail-wr1-f68.google.com with SMTP id c14so2317200wrn.7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/DmvPJlY9Tmv4EyIG/NDnFk433eow2vkRfUSRyghGd0=;
 b=ZGts9mEsV07oqMlH5CGwSt00UWM0Vhti8vRXxb5TEq9QRrXQJuYE7jQMZqw8HkyyAS
 sV/PLumRLEtdMsCQeerA3sVA2vS7CrLAEQ7hwe0cIMc+mToYOAxqRm/Pe52vxzA02HfA
 PFPISdEWNRntwUhvfwVSkiVgxtgs3PmKbjkYAEy0e3PN828LfaH9kiQq3ZgPHuJ4rybp
 FNfwTYKFCs3OdjzPHPk1WZ+Oajm3TxK8owHm/HfsLF0DOyMl0QNKjyiyApvsOQ4YH2MP
 UvZ+5hfmtLRzrHEwCA3Sv1mdagoBY/97MR1UDieUNaC6N4CX2GpiamxSKcaDcaYG7V8i
 5vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/DmvPJlY9Tmv4EyIG/NDnFk433eow2vkRfUSRyghGd0=;
 b=B98qp2F5/flf2o3G3UjCQCsCCvAJKhy7I6edI9RQiHmihWe9TY0cM4M+onKrz0eI4z
 vp8FZh5r1ismJ4/o5m/3gHhYe6XxeBhM+3gCFwr9MkCWCxpJSpEtYgMi/EnVpaXB68r3
 xF3Va2voRlPyajVV6uILhXKYxXz0wXvUnNwXXto3U/KuDoqrVXeXq84BKTeT2R5HSBi5
 4gpeMGqStALopJAFF/dDKVq6h+/9+aH/+duUyeqLxA8wiDVamS4EFmMB2B6Wcl1nzxiZ
 2bfB/WixN8vrhhBZvR4w8hmWdi7GKSnQ5J+FCwYy0jDZM/9h6r31kuiF56iL3qaEgZnj
 qywQ==
X-Gm-Message-State: APjAAAXGukRm2/6gj7QRR3IFGalzGqJho60vARZUmKj+jvzQ8KJ1zU21
 PbEPZqrAPdcwVL/PIiO2g1exNg==
X-Google-Smtp-Source: APXvYqwIgQwXtS11bXhGVH9Pe2V3XwcTTGW7CWEBZv0DL+719DfIpRZwWKHhcoYjgXjNyQ3lv3A/JQ==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr4164701wrp.71.1578672325294; 
 Fri, 10 Jan 2020 08:05:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p17sm2684593wmk.30.2020.01.10.08.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 08:05:23 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2601D1FF87;
 Fri, 10 Jan 2020 16:05:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: pbonzini@redhat.com
Subject: [kvm-unit-tests PATCH] arm: expand the timer tests
Date: Fri, 10 Jan 2020 16:05:11 +0000
Message-Id: <20200110160511.17821-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu,
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

VGhpcyB3YXMgYW4gYXR0ZW1wdCB0byByZXBsaWNhdGUgYSBRRU1VIGJ1Zy4gSG93ZXZlciB0byB0
cmlnZ2VyIHRoZQpidWcgeW91IG5lZWQgdG8gaGF2ZSBhbiBvZmZzZXQgc2V0IGluIEVMMiB3aGlj
aCBrdm0tdW5pdC10ZXN0cyBpcwp1bmFibGUgdG8gZG8uIEhvd2V2ZXIgaXQgZG9lcyBleGVyY2lz
ZSBzb21lIG1vcmUgY29ybmVyIGNhc2VzLgoKQnVnOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5l
dC9idWdzLzE4NTkwMjEKU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBs
aW5hcm8ub3JnPgotLS0KIGFybS90aW1lci5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysr
KystCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2FybS90aW1lci5jIGIvYXJtL3RpbWVyLmMKaW5kZXggZjM5MGU4ZS4uYWUxZDI5
OSAxMDA2NDQKLS0tIGEvYXJtL3RpbWVyLmMKKysrIGIvYXJtL3RpbWVyLmMKQEAgLTIxNCwyMSAr
MjE0LDQ2IEBAIHN0YXRpYyB2b2lkIHRlc3RfdGltZXIoc3RydWN0IHRpbWVyX2luZm8gKmluZm8p
CiAJICogc3RpbGwgcmVhZCB0aGUgcGVuZGluZyBzdGF0ZSBldmVuIGlmIGl0J3MgZGlzYWJsZWQu
ICovCiAJc2V0X3RpbWVyX2lycV9lbmFibGVkKGluZm8sIGZhbHNlKTsKIAorCS8qIFZlcmlmeSBj
b3VudCBnb2VzIHVwICovCisJcmVwb3J0KGluZm8tPnJlYWRfY291bnRlcigpID49IG5vdywgImNv
dW50ZXIgaW5jcmVtZW50cyIpOworCiAJLyogRW5hYmxlIHRoZSB0aW1lciwgYnV0IHNjaGVkdWxl
IGl0IGZvciBtdWNoIGxhdGVyICovCiAJaW5mby0+d3JpdGVfY3ZhbChsYXRlcik7CiAJaW5mby0+
d3JpdGVfY3RsKEFSQ0hfVElNRVJfQ1RMX0VOQUJMRSk7CiAJaXNiKCk7Ci0JcmVwb3J0KCFnaWNf
dGltZXJfcGVuZGluZyhpbmZvKSwgIm5vdCBwZW5kaW5nIGJlZm9yZSIpOworCXJlcG9ydCghZ2lj
X3RpbWVyX3BlbmRpbmcoaW5mbyksICJub3QgcGVuZGluZyBiZWZvcmUgMTBzIik7CisKKwkvKiBD
aGVjayB3aXRoIGEgbWF4aW11bSBwb3NzaWJsZSBjdmFsICovCisJaW5mby0+d3JpdGVfY3ZhbChV
SU5UNjRfTUFYKTsKKwlpc2IoKTsKKwlyZXBvcnQoIWdpY190aW1lcl9wZW5kaW5nKGluZm8pLCAi
bm90IHBlbmRpbmcgYmVmb3JlIFVJTlQ2NF9NQVgiKTsKKworCS8qIGFsc28gYnkgc2V0dGluZyB0
dmFsICovCisJaW5mby0+d3JpdGVfdHZhbCh0aW1lXzEwcyk7CisJaXNiKCk7CisJcmVwb3J0KCFn
aWNfdGltZXJfcGVuZGluZyhpbmZvKSwgIm5vdCBwZW5kaW5nIGJlZm9yZSAxMHMgKHZpYSB0dmFs
KSIpOworCXJlcG9ydF9pbmZvKCJUVkFMIGlzICVkIChkZWx0YSBDVkFMICVsZCkgdGlja3MiLAor
CQkgICAgaW5mby0+cmVhZF90dmFsKCksIGluZm8tPnJlYWRfY3ZhbCgpIC0gaW5mby0+cmVhZF9j
b3VudGVyKCkpOwogCisgICAgICAgIC8qIGNoZWNrIHBlbmRpbmcgb25jZSBjdmFsIGlzIGJlZm9y
ZSBub3cgKi8KIAlpbmZvLT53cml0ZV9jdmFsKG5vdyAtIDEpOwogCWlzYigpOwogCXJlcG9ydChn
aWNfdGltZXJfcGVuZGluZyhpbmZvKSwgImludGVycnVwdCBzaWduYWwgcGVuZGluZyIpOworCXJl
cG9ydF9pbmZvKCJUVkFMIGlzICVkIHRpY2tzIiwgaW5mby0+cmVhZF90dmFsKCkpOwogCiAJLyog
RGlzYWJsZSB0aGUgdGltZXIgYWdhaW4gYW5kIHByZXBhcmUgdG8gdGFrZSBpbnRlcnJ1cHRzICov
CiAJaW5mby0+d3JpdGVfY3RsKDApOwogCXNldF90aW1lcl9pcnFfZW5hYmxlZChpbmZvLCB0cnVl
KTsKIAlyZXBvcnQoIWdpY190aW1lcl9wZW5kaW5nKGluZm8pLCAiaW50ZXJydXB0IHNpZ25hbCBu
byBsb25nZXIgcGVuZGluZyIpOwogCisJLyogUUVNVSBidWcgd2hlbiBjbnR2b2ZmX2VsMiA+IDAK
KwkgKiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9idWdzLzE4NTkwMjEgKi8KKwlpbmZvLT53
cml0ZV9jdGwoQVJDSF9USU1FUl9DVExfRU5BQkxFKTsKKwlpbmZvLT53cml0ZV9jdmFsKFVJTlQ2
NF9NQVgpOworCWlzYigpOworCXJlcG9ydCghZ2ljX3RpbWVyX3BlbmRpbmcoaW5mbyksICJub3Qg
cGVuZGluZyBiZWZvcmUgVUlOVDY0X01BWCAoaXJxcyBvbikiKTsKKwlpbmZvLT53cml0ZV9jdGwo
MCk7CisKIAlyZXBvcnQodGVzdF9jdmFsXzEwbXNlYyhpbmZvKSwgImxhdGVuY3kgd2l0aGluIDEw
IG1zIik7CiAJcmVwb3J0KGluZm8tPmlycV9yZWNlaXZlZCwgImludGVycnVwdCByZWNlaXZlZCIp
OwogCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpo
dHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=

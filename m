Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FF62C5CB
	for <lists+kvmarm@lfdr.de>; Wed, 16 Nov 2022 18:04:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FC5F4B8EE;
	Wed, 16 Nov 2022 12:04:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wyjd0pjT70zK; Wed, 16 Nov 2022 12:04:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B1F14B8B3;
	Wed, 16 Nov 2022 12:04:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 426204B8D0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 12:04:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nCxmxha4+IE7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Nov 2022 12:04:02 -0500 (EST)
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com
 [209.85.208.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B1E8B4B8F2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 12:03:58 -0500 (EST)
Received: by mail-ed1-f73.google.com with SMTP id
 y18-20020a056402359200b004635f8b1bfbso12964128edc.17
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 09:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=w3CJ9WqAwrI5MWLbxzP4zufoJqf7Sp8iQz9NzGEzNss=;
 b=RRQT8R8I8/484VEB7cZtngMuD3T4Py3IF82wRk+y2FNtS+kUp8hwTPzl3tIwgvoHdW
 OfMMBdCkQOPYoO1cVBvZ+tfGLnLJpB9pDhaN7v7wIhNHpAqrTPXcmcO82vmEUsJDO3F3
 5bmHSPlxCy1B2rBozvE2SGkdJ+JHBhwWqOz2hbVFkg8YRDSBkH59SdyGZLEMacOQr1y7
 DKsPdZCaBMauYRGyAPLO9IBwCELxblbYZjnARDadXRCVgiPv4KCjnTCn1TbFZXyYkGpt
 E8rmNyCUP73bX9xXIaUa8d0tyHdtHjXMd4nwBYClTcug3wD/sJ2ay8q/jGEx1h2u+Wmf
 2j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3CJ9WqAwrI5MWLbxzP4zufoJqf7Sp8iQz9NzGEzNss=;
 b=HEkHTWKUeeUfxBQ1uwMqWR7E9jx1l1nuXfGJ5A0LLf9a3HCu7oKEX4txRpb/UnCCVL
 WSO8P1+zkBNvqzVpG/dJBhOj6Go0MPL2OIVyeCl7TIZ9j3ijN37EbNclYhcME4bER6SV
 GiZJXtGqFq0NgNZnV7bj0eRN/knRAjvGqof0v0gXZf2TP5zj/zIxNd/DwNG6s6eXMhNY
 XaCC6Pk2EGrpVXCOk6s8844SfP+0rX/BCJGenMO8yFilsFNTb923PH0ptwRAIuFTR/8z
 /SHJeAwKEWjpwM+93uhi1amtUIfPUwGQonJTGgCxE/+rjkT8BzgoS+/PQT7FY89W0GZS
 WCog==
X-Gm-Message-State: ANoB5pn+wvA0DiRodVyfXPncVK06kSL73Ms4GP67ap5mCZC4CKKYOWSy
 S4PIornNvJG6lvoht2JthShZQZPOQQZY
X-Google-Smtp-Source: AA0mqf6JS80gQxyHP/kM0kvdlOGbGQY5Uhg5+P6sHPSkH1Zbh79if5Kzo0s/F9hrUkjGecANQVWXuHZIGu3M
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:907:9142:b0:78d:9c18:7307 with SMTP id
 l2-20020a170907914200b0078d9c187307mr20201932ejs.23.1668618237769; Wed, 16
 Nov 2022 09:03:57 -0800 (PST)
Date: Wed, 16 Nov 2022 17:03:31 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-9-qperret@google.com>
Subject: [PATCH 08/12] KVM: arm64: Add FF-A helpers to share/unshare memory
 with secure world
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Oliver Upton <oliver.upton@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Andrew Walbran <qwandor@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

From: Will Deacon <will@kernel.org>

Extend pKVM's memory protection code so that we can update the host's
stage-2 page-table to track pages shared with secure world by the host
using FF-A and prevent those pages from being mapped into a guest.

Co-developed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  3 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 68 +++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index b7bdbe63deed..0972faccc2af 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -57,6 +57,7 @@ extern struct host_mmu host_mmu;
 enum pkvm_component_id {
 	PKVM_ID_HOST,
 	PKVM_ID_HYP,
+	PKVM_ID_FFA,
 };
 
 extern unsigned long hyp_nr_cpus;
@@ -66,6 +67,8 @@ int __pkvm_host_share_hyp(u64 pfn);
 int __pkvm_host_unshare_hyp(u64 pfn);
 int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
+int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
+int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 552653fa18be..e721fba3bb33 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -835,6 +835,13 @@ static int check_share(struct pkvm_mem_share *share)
 	case PKVM_ID_HYP:
 		ret = hyp_ack_share(completer_addr, tx, share->completer_prot);
 		break;
+	case PKVM_ID_FFA:
+		/*
+		 * We only check the host; the secure side will check the other
+		 * end when we forward the FFA call.
+		 */
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -863,6 +870,13 @@ static int __do_share(struct pkvm_mem_share *share)
 	case PKVM_ID_HYP:
 		ret = hyp_complete_share(completer_addr, tx, share->completer_prot);
 		break;
+	case PKVM_ID_FFA:
+		/*
+		 * We're not responsible for any secure page-tables, so there's
+		 * nothing to do here.
+		 */
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -911,6 +925,10 @@ static int check_unshare(struct pkvm_mem_share *share)
 	case PKVM_ID_HYP:
 		ret = hyp_ack_unshare(completer_addr, tx);
 		break;
+	case PKVM_ID_FFA:
+		/* See check_share() */
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -939,6 +957,10 @@ static int __do_unshare(struct pkvm_mem_share *share)
 	case PKVM_ID_HYP:
 		ret = hyp_complete_unshare(completer_addr, tx);
 		break;
+	case PKVM_ID_FFA:
+		/* See __do_share() */
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1228,3 +1250,49 @@ void hyp_unpin_shared_mem(void *from, void *to)
 	hyp_unlock_component();
 	host_unlock_component();
 }
+
+int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
+{
+	int ret;
+	struct pkvm_mem_share share = {
+		.tx	= {
+			.nr_pages	= nr_pages,
+			.initiator	= {
+				.id	= PKVM_ID_HOST,
+				.addr	= hyp_pfn_to_phys(pfn),
+			},
+			.completer	= {
+				.id	= PKVM_ID_FFA,
+			},
+		},
+	};
+
+	host_lock_component();
+	ret = do_share(&share);
+	host_unlock_component();
+
+	return ret;
+}
+
+int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
+{
+	int ret;
+	struct pkvm_mem_share share = {
+		.tx	= {
+			.nr_pages	= nr_pages,
+			.initiator	= {
+				.id	= PKVM_ID_HOST,
+				.addr	= hyp_pfn_to_phys(pfn),
+			},
+			.completer	= {
+				.id	= PKVM_ID_FFA,
+			},
+		},
+	};
+
+	host_lock_component();
+	ret = do_unshare(&share);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
